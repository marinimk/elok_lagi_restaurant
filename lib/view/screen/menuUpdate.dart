// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// import 'dart:math' as math;

class MenuUpdate extends StatefulWidget {
  @override
  _MenuUpdateState createState() => _MenuUpdateState();
}

class _MenuUpdateState extends State<MenuUpdate> {
  // var _description; //= 'Description makanan yang sungguh ranggi';
  // final description = new TextEditingController();
  bool isReadOnly = true;
  bool isVisible = true;
  // String btnText = 'Edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu update'),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        //color: Colors.pink,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: 200,
                // clipBehavior: Clip.values,
                // height: 150,
                // fit: BoxFit.fitHeight,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset(
                      'assets/images/pastry.png',
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.bottomCenter,
                color: Color.fromRGBO(255, 255, 255, 0.3),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Pastry',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          // color: Colors.red,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Description:',
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
                          // color: Colors.purple,
                          // height: 50,
                          child: TextFormField(
                            scrollPadding: EdgeInsets.zero,
                            maxLines: 5,
                            maxLength: 255,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            // enabled: false,
                            readOnly: isReadOnly,
                            initialValue:
                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,',
                            // controller: description,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              // labelText: 'testing the description',
                            ),
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          //color: Colors.purple,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Allergens:',
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
                          // color: Colors.purple,
                          // height: 50,
                          child: TextFormField(
                            scrollPadding: EdgeInsets.zero,
                            maxLines: 2,
                            maxLength: 255,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            // enabled: false,
                            readOnly: isReadOnly,
                            initialValue: 'Nuts, Dairy, Gluten',
                            // controller: description,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              // labelText: 'testing the description',
                            ),
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          //color: Colors.purple,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Available pax:',
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
                          // color: Colors.purple,
                          // height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            scrollPadding: EdgeInsets.zero,
                            // maxLines: 5,
                            // maxLength: 255,
                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            // enabled: false,
                            readOnly: isReadOnly,
                            initialValue: '3',
                            // controller: description,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              // labelText: 'testing the description',
                            ),
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          //color: Colors.purple,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Price:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          // color: Colors.purple,
                          // height: 50,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            // maxLines: 2,
                            // maxLength: 255,
                            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            // enabled: false,
                            // initialValue: 'RM 2.00',
                            // controller: description,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              // labelText: 'testing the description',
                            ),
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 0.3,
                          //color: Colors.purple,
                          // height: 50,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Normal Price:',
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
                          //color: Colors.purple,
                          // height: 50,
                          child: Text(
                            '',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 5,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isVisible,
                          child: Container(
                            child: OutlinedButton(
                              // icon
                              onPressed: () {
                                setState(() {
                                  // _description = description.text;
                                  isVisible = !isVisible;
                                  isReadOnly = !isReadOnly;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    // Icon(icon),
                                    'EDIT',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isVisible,
                          child: Container(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  // _description = description.text;
                                  isReadOnly = !isReadOnly;
                                  isVisible = !isVisible;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.save,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    // Icon(icon),
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(child: SizedBox(width: 5)),
                        Visibility(
                          visible: !isVisible,
                          child: Container(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  // _description = description.text;
                                  // isReadOnly = !isReadOnly;
                                  // isVisible = !isVisible;
                                  buildShowAlert(context);
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    // Icon(icon),
                                    'DELETE',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Text('decription is $_description'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildShowAlert(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      // body: Center(
      //   child: Text(
      //     'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
      //     style: TextStyle(fontStyle: FontStyle.italic),
      //   ),
      // ),
      title: 'Delete item name',
      desc: 'Are you sure you want to delete item name?',
      // btnCancel: btncancel
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}
