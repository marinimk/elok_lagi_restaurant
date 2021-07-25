import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<RestaurantData>(
        stream: DatabaseService(uid: user.uid).restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RestaurantData restaurant = snapshot.data;
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(restaurant.imageURL),
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
