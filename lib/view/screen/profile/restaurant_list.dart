import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/restaurant_tile.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<RestaurantData>(
        stream: DatabaseService(uid: user.uid).restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RestaurantData restaurantData = snapshot.data;
            return RestaurantTile(restaurant: restaurantData);
          } else {
            return Loading();
          }
        });
  }
}
