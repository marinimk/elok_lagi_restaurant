import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
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

class MenuUpdate extends StatefulWidget {
  @override
  _MenuUpdateState createState() => _MenuUpdateState();

  final Food food;
  final String fid;
  MenuUpdate({this.food, this.fid});
}

class _MenuUpdateState extends State<MenuUpdate> {
  bool isReadOnly = true;
  bool isVisible = true;
  File _image;
  String _userImageUrl;

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
    return StreamBuilder<Food>(
      stream: DatabaseService(uid: user.uid, fid: widget.fid).foodData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Food foodData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Update food'),
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
                              child: Image.network(foodData.imageURL,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  alignment: Alignment.center),
                            ),
                            Visibility(
                              visible: !isVisible,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      var image = await ImagePicker().getImage(
                                          source: ImageSource.gallery);
                                      setState(() {
                                        _image = File(image.path);
                                      });
                                    },
                                    child: Icon(Icons.camera_alt),
                                  ),
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
                            menuUpdateField(
                                context, 'Name', foodData.name, 50, 1, false),
                            divider(),
                            menuUpdateField(context, 'Description',
                                foodData.description, 255, 5, false),
                            divider(),
                            menuUpdateField(context, 'Available pax',
                                foodData.pax.toString(), 3, 1, true),
                            divider(),
                            menuUpdateField(context, 'Selling price',
                                foodData.salePrice.toString(), 5, 1, true),
                            divider(),
                            menuUpdateField(context, 'Original price',
                                foodData.oriPrice.toString(), 5, 1, true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle(),
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                          isReadOnly = !isReadOnly;
                                        });
                                      },
                                      child: buttonTextRow(Icons.edit, 'EDIT'),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible: isVisible,
                                    child: SizedBox(width: 5)),
                                Visibility(
                                  visible: isVisible,
                                  child: Container(
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle().copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          AwesomeDialog(
                                            context: context,
                                            borderSide: BorderSide(
                                                width: 5,
                                                color: colorsConst[100]),
                                            dialogType: DialogType.WARNING,
                                            animType: AnimType.SCALE,
                                            title:
                                                'Are you sure you want to delete \'${foodData.name.inCaps}\'?',
                                            // desc: 'Do you want to change the status to $newStatus?',
                                            showCloseIcon: true,
                                            btnCancelText: 'Cancel',
                                            btnOkText: 'Yes',
                                            btnCancelOnPress: () {
                                              setState(() {});
                                            },
                                            btnOkOnPress: () async {
                                              DatabaseService(
                                                      uid: user.uid,
                                                      fid: widget.fid)
                                                  .deleteFood();
                                              Navigator.pop(context);
                                            },
                                          )..show();
                                        });
                                      },
                                      child:
                                          buttonTextRow(Icons.delete, 'DELETE'),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: !isVisible,
                                  child: Container(
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
                                        Reference firebaseStorageRef =
                                            FirebaseStorage.instance
                                                .ref()
                                                .child(fileName);
                                        UploadTask uploadTask =
                                            firebaseStorageRef.putFile(_image);
                                        TaskSnapshot taskSnapshot =
                                            await uploadTask;
                                        await taskSnapshot.ref
                                            .getDownloadURL()
                                            .then((urlImage) {
                                          _userImageUrl = urlImage;
                                        });
                                        setState(() {
                                          isReadOnly = !isReadOnly;
                                          isVisible = !isVisible;
                                        });
                                        await DatabaseService(
                                                uid: user.uid, fid: widget.fid)
                                            .updateFood(
                                                _name ?? foodData.name,
                                                _description ??
                                                    foodData.description,
                                                _oriPrice ?? foodData.oriPrice,
                                                _salePrice ??
                                                    foodData.salePrice,
                                                _pax ?? foodData.pax,
                                                _userImageUrl ??
                                                    foodData.imageURL);
                                        // Navigator.pop(context);
                                      },
                                      child: buttonTextRow(Icons.save, 'SAVE'),
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible: !isVisible,
                                    child: SizedBox(width: 5)),
                                Visibility(
                                  visible: !isVisible,
                                  child: Container(
                                    child: ElevatedButton(
                                      style: elevatedButtonStyle().copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        setState(() => Navigator.pop(context));
                                      },
                                      child:
                                          buttonTextRow(Icons.cancel, 'CANCEL'),
                                    ),
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
        } else {
          return Loading();
        }
      },
    );
  }

  // Future getImage() async {
  //   //allows us to get the image from the gallery
  //   var image = await ImagePicker().getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  // Future uploadPic(BuildContext context) async {
  //   String fileName = basename(_image.path);
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_image);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   await taskSnapshot.ref.getDownloadURL().then((urlImage) {
  //     _userImageUrl = urlImage;
  //   });
  // }

  Divider divider() {
    return Divider(thickness: 1, height: 5);
  }

  Row menuUpdateField(BuildContext context, String field, String initVal,
      int maxLength, int maxLine, bool isNum) {
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
            readOnly: isReadOnly,
            initialValue: initVal,
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
