import 'dart:io';

import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/profile/restaurant_tile.dart';
import 'package:elok_lagi_restaurant/view/widgets/profile/profile_picture.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  final List<String> category = [
    'Western Food',
    'Malaysian Food',
    'Fusion',
    'Italian',
    'Desserts',
  ];

  String _name;
  String _category;
  String _location;
  String _phoneNum;
  String _status;

  String _userImageUrl;
  File _image;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return StreamBuilder<RestaurantData>(
      stream: DatabaseService(uid: user.uid).restaurantData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          RestaurantData restData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                        radius: 80.0,
                        backgroundImage: _image == null
                            ? NetworkImage(restData
                                .imageURL)
                            : FileImage(_image)),
                    ElevatedButton(
                      onPressed: () async {
                        var image = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        setState(() {
                          _image = File(image.path);
                        });
                      },
                      child: _image == null
                          ? Icon(Icons.add_photo_alternate)
                          : Icon(Icons.camera_alt_outlined),
                      style: circularElevatedButton(),
                    ),
                  ],
                ),
                profileUpdateField(Icons.person_outline, 'Name', restData.name),
                profileUpdateDropDown(),
                profileUpdateField(
                    Icons.pin_drop_outlined, 'Location', restData.location),
                profileUpdateField(Icons.phone_android_outlined, 'Phone Number',
                    restData.phoneNum),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      // style: ,
                      child: buttonTextRow(Icons.check_circle, 'Update'),
                      style: elevatedButtonStyle().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
                        String fileName =
                            DateTime.now().millisecondsSinceEpoch.toString() +
                                basename(_image.path);
                        Reference firebaseStorageRef =
                            FirebaseStorage.instance.ref().child(fileName);
                        UploadTask uploadTask =
                            firebaseStorageRef.putFile(_image);
                        TaskSnapshot taskSnapshot = await uploadTask;
                        await taskSnapshot.ref
                            .getDownloadURL()
                            .then((urlImage) {
                          _userImageUrl = urlImage;
                        });
                        if (!_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid)
                              .updateRestaurantData(
                                  _name ?? restData.name,
                                  _category ?? restData.category,
                                  _location ?? restData.location,
                                  _phoneNum ?? restData.phoneNum,
                                  _status ?? restData.status,
                                  _userImageUrl ?? restData.imageURL);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data Saved')));
                        }
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: buttonTextRow(Icons.cancel, 'Cancel'),
                      style: elevatedButtonStyle().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  // Future<void> getImage() async {
  //   //allows us to get the image from the gallery
  //   var image = await ImagePicker().getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _imageFile = File(image.path);
  //   });
  // }

  // Future uploadPic(BuildContext context) async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
  //       basename(_imageFile.path);
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   TaskSnapshot taskSnapshot = await uploadTask;

  //   await taskSnapshot.ref.getDownloadURL().then((urlImage) {
  //     userImageUrl = urlImage;
  //   });

  //   setState(() {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('image uploaded')));
  //   });
  // }

  DropdownButtonFormField profileUpdateDropDown() {
    return DropdownButtonFormField(
      decoration: textInputDecoration(Icons.category_outlined, null).copyWith(),
      hint: Text('Category'),
      items: category.map((cat) {
        return DropdownMenuItem(
          value: cat,
          child: Text(cat),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _category = val;
        });
      },
    );
  }

  Padding profileUpdateField(IconData icon, String title, String initVal) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initVal,
        validator: (val) => val.isEmpty
            ? 'please field in your new $widget.title.toLowerCase()'
            : '',
        onChanged: (val) {
          setState(() {
            switch (title) {
              case 'Name':
                _name = val;
                break;
              case 'Location':
                _location = val;
                break;
              case 'Phone Number':
                _phoneNum = val;
                break;
              default:
            }
          });
        },
        decoration: textInputDecoration(icon, title),
      ),
    );
  }
}
