import 'dart:io';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  DateTime _prepDateTime;
  DateTime _expDateTime;

  @override
  void initState() {
    super.initState();
    _prepDateTime = DateTime.now();
    _expDateTime = DateTime.now();
  }

  final _salePriceController = TextEditingController();
  final _oriPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      menuUpdateNameField(context),
                      divider(),
                      menuUpdateDescField(context),
                      divider(),
                      menuUpdatePrepDateTimeField(context),
                      divider(),
                      menuUpdateExpDateTimeField(context),
                      divider(),
                      menuUpdatePaxField(context),
                      divider(),
                      menuUpdateOriField(context),
                      divider(),
                      menuUpdateSaleField(context),
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
                                if (_formKey.currentState.validate()) {
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

                                  await DatabaseService(uid: user.uid).addFood(
                                      _name,
                                      _description,
                                      _oriPrice,
                                      _salePrice,
                                      _pax,
                                      _userImageUrl);
                                  Navigator.pop(context);
                                }
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

  Row menuUpdateNameField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Name :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 50,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) {
              setState(() {
                _name = val;
              });
            },
            validator: RequiredValidator(
                errorText: 'Please enter the name of this item'),
          ),
        ),
      ],
    );
  }

  Row menuUpdatePrepDateTimeField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Prepared Date & Time :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: true,
            initialValue:
                '${_prepDateTime.day}/${_prepDateTime.month}/${_prepDateTime.year} ${_prepDateTime.hour}:${_prepDateTime.minute}',
            decoration: textInputDecoration(null, ''),
            style: TextStyle(fontSize: 16),
            onTap: () async {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2019, 6, 7), onChanged: (val) {
                setState(() {
                  _prepDateTime = val;
                });
                print(val);
              }, onConfirm: (val) {
                setState(() {
                  _prepDateTime = val;
                });
                print('$val');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            validator:
                RequiredValidator(errorText: 'Enter the prepared date & time'),
          ),
        ),
      ],
    );
  }

  Row menuUpdateExpDateTimeField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Expired Date & Time :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: true,
            initialValue:
                '${_expDateTime.day}/${_expDateTime.month}/${_expDateTime.year} ${_expDateTime.hour}:${_expDateTime.minute}',
            decoration: textInputDecoration(null, ''),
            style: TextStyle(fontSize: 16),
            onTap: () async {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2019, 6, 7), onChanged: (val) {
                setState(() {
                  _expDateTime = val;
                });
                print(val);
              }, onConfirm: (val) {
                setState(() {
                  _expDateTime = val;
                });
                print('$val');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            validator:
                RequiredValidator(errorText: 'Enter the expired date & time'),
          ),
        ),
      ],
    );
  }

  Row menuUpdateDescField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Description :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 5,
            maxLength: 255,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) {
              setState(() {
                _description = val;
              });
            },
            validator: RequiredValidator(
                errorText: 'Please enter the description of this item'),
          ),
        ),
      ],
    );
  }

  Row menuUpdatePaxField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Available pax :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 3,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) {
              setState(() {
                _pax = int.parse(val);
              });
            },
            validator: RequiredValidator(
                errorText: 'Please enter the number of pax of this item'),
          ),
        ),
      ],
    );
  }

  Row menuUpdateSaleField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Selling Price :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
              // keyboardType: TextInputType.number,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              scrollPadding: EdgeInsets.zero,
              maxLines: 1,
              maxLength: 5,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: textInputDecoration(null, ''),
              style: TextStyle(
                fontSize: 16,
              ),
              controller: _salePriceController,
              onChanged: (val) {
                setState(() {
                  _salePrice = double.parse(val);
                });
              },
              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              validator: (val) {
                String error;
                if (val.isEmpty) {
                  error = 'Please enter the original price of this item';
                } else if (double.parse(val) >
                    double.parse(_oriPriceController.text) * 0.8) {
                  error = 'Selling price cannot exceed 80% original price';
                }
                return error;
              }),
        ),
      ],
    );
  }

  Row menuUpdateOriField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Original Price :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 5,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            controller: _oriPriceController,
            onChanged: (val) {
              setState(() {
                _oriPrice = double.parse(val);
              });
            },
            inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
            validator: RequiredValidator(
                errorText: 'Please enter the original price of this item'),
          ),
        ),
      ],
    );
  }
}
