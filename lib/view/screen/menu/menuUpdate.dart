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
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  DateTime _prepDateTime;
  DateTime _expDateTime;

  @override
  void initState() {
    super.initState();
    _prepDateTime = DateTime.now();
    _expDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Food>(
      stream: DatabaseService(uid: user.uid, fid: widget.fid).foodData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Food foodData = snapshot.data;
          return Scaffold(
            appBar: AppBar(title: Text('Update food')),
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
                                    alignment: Alignment.center)),
                            Visibility(
                                visible: !isVisible,
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FloatingActionButton(
                                            onPressed: () async {
                                              var image = await ImagePicker()
                                                  .getImage(
                                                      source:
                                                          ImageSource.gallery);
                                              setState(() =>
                                                  _image = File(image.path));
                                            },
                                            child: Icon(Icons.camera_alt))))),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            divider(),
                            menuUpdateNameField(context, foodData),
                            divider(),
                            menuUpdateDescField(context, foodData),
                            divider(),
                            menuUpdatePrepDateTimeField(context, foodData),
                            divider(),
                            menuUpdateExpDateTimeField(context, foodData),
                            divider(),
                            menuUpdatePaxField(context, foodData),
                            divider(),
                            menuUpdateOriField(context, foodData),
                            divider(),
                            menuUpdateSaleField(context, foodData),
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
                                                  Colors.red)),
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
                                        if (_formKey.currentState.validate()) {
                                          String fileName = DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString() +
                                              basename(_image.path);
                                          Reference firebaseStorageRef =
                                              FirebaseStorage.instance
                                                  .ref()
                                                  .child(fileName);
                                          UploadTask uploadTask =
                                              firebaseStorageRef
                                                  .putFile(_image);
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
                                                  uid: user.uid,
                                                  fid: widget.fid)
                                              .updateFood(
                                                  _name ?? foodData.name,
                                                  _description ??
                                                      foodData.description,
                                                  _oriPrice ??
                                                      foodData.oriPrice,
                                                  _salePrice ??
                                                      foodData.salePrice,
                                                  _pax ?? foodData.pax,
                                                  _userImageUrl ??
                                                      foodData.imageURL);
                                          Navigator.pop(context);
                                        }
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
                                                  Colors.red)),
                                      onPressed: () => setState(
                                          () => Navigator.pop(context)),
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

  Divider divider() {
    return Divider(thickness: 1, height: 5);
  }

  Row menuUpdateNameField(BuildContext context, Food foodData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Name :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 50,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: isReadOnly,
            initialValue: foodData.name,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(fontSize: 16),
            onChanged: (val) => setState(() => _name = val),
            validator: RequiredValidator(errorText: 'Enter the name'),
          ),
        ),
      ],
    );
  }

  Row menuUpdateDescField(BuildContext context, Food foodData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Description :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding: EdgeInsets.zero,
            maxLines: 5,
            maxLength: 255,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: isReadOnly,
            initialValue: foodData.description,
            decoration: textInputDecoration(null, ''),
            style: TextStyle(fontSize: 16),
            onChanged: (val) => setState(() => _description = val),
            validator: RequiredValidator(errorText: 'Enter the description'),
          ),
        ),
      ],
    );
  }

  Row menuUpdatePrepDateTimeField(BuildContext context, Food foodData) {
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

  Row menuUpdateExpDateTimeField(BuildContext context, Food foodData) {
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

  Row menuUpdatePaxField(BuildContext context, Food foodData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Available pax :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 3,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: isReadOnly,
            initialValue: foodData.pax.toString(),
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) => setState(() => _pax = int.parse(val)),
            validator: (val) {
              String error;
              if (val.isEmpty || int.parse(val) == 0)
                error = 'Enter the number of pax';
              return error;
            },
          ),
        ),
      ],
    );
  }

  Row menuUpdateSaleField(BuildContext context, Food foodData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Selling Price :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 5,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: isReadOnly,
            initialValue: foodData.salePrice.toString(),
            decoration: textInputDecoration(null, ''),
            style: TextStyle(fontSize: 16),
            onChanged: (val) => setState(() => _salePrice = double.parse(val)),
            inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
            validator: (val) {
              String error;
              if (val.isEmpty || double.parse(val) == 0.0)
                error = 'Enter the selling price';
              return error;
            },
          ),
        ),
      ],
    );
  }

  Row menuUpdateOriField(BuildContext context, Food foodData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Original Price :',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            maxLines: 1,
            maxLength: 5,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            readOnly: isReadOnly,
            initialValue: foodData.oriPrice.toString(),
            decoration: textInputDecoration(null, ''),
            style: TextStyle(
              fontSize: 16,
            ),
            onChanged: (val) {
              setState(() {
                _oriPrice = double.parse(val);
              });
            },
            inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
            validator: (val) {
              String error;
              if (val.isEmpty || double.parse(val) == 0.0)
                error = 'Enter the original price';
              return error;
            },
          ),
        ),
      ],
    );
  }
}
