import 'dart:io';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/food.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class MenuAdd extends StatefulWidget {
  @override
  _MenuAddState createState() => _MenuAddState();
}

class _MenuAddState extends State<MenuAdd> {
  bool isReadOnly = false;
  bool isVisible = false;
  File _image;
  String _userImageUrl = '';

  final _formKey = GlobalKey<FormState>();

  String _name;
  String _description;
  double _oriPrice;
  double _salePrice;
  int _pax;

  @override
  Widget build(BuildContext context) {
    // final food = Provider.of<Food>(context);
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new item'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: colorsConst[100],
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: (_image != null)
                            ? Image.file(_image,
                                fit: BoxFit.cover,
                                width: 200,
                                alignment: Alignment.center)
                            : Image.asset(
                                'assets/images/defaultFood.png',
                                fit: BoxFit.cover,
                                width: 200,
                                alignment: Alignment.center,
                              ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () async {
                              var image = await ImagePicker()
                                  .getImage(source: ImageSource.gallery);
                              setState(() {
                                _image = File(image.path);
                              });
                            },
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      divider(),
                      menuAddField(context, 'Name', 50, 1, false),
                      divider(),
                      menuAddField(context, 'Description', 255, 5, false),
                      divider(),
                      menuAddField(context, 'Available pax', 3, 1, true),
                      divider(),
                      menuAddField(context, 'Selling price', 5, 1, true),
                      divider(),
                      menuAddField(context, 'Original price', 5, 1, true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: ElevatedButton(
                              style: elevatedButtonStyle().copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              onPressed: () async {
                                String fileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString() +
                                    basename(_image.path);
                                Reference firebaseStorageRef = FirebaseStorage
                                    .instance
                                    .ref()
                                    .child(fileName);
                                UploadTask uploadTask =
                                    firebaseStorageRef.putFile(_image);
                                TaskSnapshot taskSnapshot = await uploadTask;
                                await taskSnapshot.ref
                                    .getDownloadURL()
                                    .then((urlImage) {
                                  _userImageUrl = urlImage;
                                });

                                // setState(() {});
                                await DatabaseService(uid: user.uid).addFood(
                                    _name,
                                    _description,
                                    _oriPrice,
                                    _salePrice,
                                    _pax,
                                    _userImageUrl);
                                Navigator.pop(context);
                              },
                              child: buttonTextRow(Icons.save, 'SAVE'),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            child: ElevatedButton(
                              style: elevatedButtonStyle().copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              onPressed: () {
                                setState(() => Navigator.pop(context));
                              },
                              child: buttonTextRow(Icons.cancel, 'CANCEL'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(thickness: 1, height: 5);
  }

  Row menuAddField(BuildContext context, String field, int maxLength,
      int maxLine, bool isNum) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.3,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '$field :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: isNum ? TextInputType.number : TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: maxLine,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) {
              setState(() {
                switch (field) {
                  case 'Name':
                    _name = val;
                    break;
                  case 'Description':
                    _description = val;
                    break;
                  case 'Available pax':
                    _pax = int.parse(val);
                    break;
                  case 'Selling price':
                    _salePrice = double.parse(val);
                    break;
                  case 'Original price':
                    _oriPrice = double.parse(val);
                    break;
                  default:
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
