import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/profile_picture.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/restaurant_list.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    double _screenWidth = MediaQuery.of(context).size.width;
    final user = Provider.of<Users>(context);
    return StreamProvider<RestaurantData>.value(
      initialData: RestaurantData(),
      value: DatabaseService(uid: user.uid).restaurantData,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => updateProfileBottomSheet(context),
          child: Icon(Icons.create),
        ),
        appBar: AppBar(title: Text('PROFILE')),
        drawer: ElrDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              width: _screenWidth,
              height: _screenHeight * 0.3,
              color: colorsConst[100],
              child: Center(
                child: ProfilePicture(),
              ),
            ),
            Container(
              // flex: 5,
              height: _screenHeight * 0.5,
              child: RestaurantList(),
            ),
          ],
        ),
      ),
    );
  }

  Future updateProfileBottomSheet(BuildContext context) {
    Size _screensize = MediaQuery.of(context).size;
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: colorsConst[100],
                    border: Border.all(width: 5, color: colorsConst[300]),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: _screensize.height * 0.7,
                width: _screensize.width * 0.85,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Update your credentials',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  UpdateProfile(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
