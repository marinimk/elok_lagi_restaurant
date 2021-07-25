import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';

class RestaurantTile extends StatefulWidget {
  final RestaurantData restaurant;
  RestaurantTile({this.restaurant});

  @override
  _RestaurantTileState createState() => _RestaurantTileState();
}

class _RestaurantTileState extends State<RestaurantTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        restaurantInfoCard(
            context, Icons.person_outline, 'Name', widget.restaurant.name),
        restaurantInfoCard(context, Icons.category_outlined, 'Category',
            widget.restaurant.category),
        restaurantInfoCard(context, Icons.pin_drop_outlined, 'Location',
            widget.restaurant.location),
        restaurantInfoCard(context, Icons.phone_android_outlined,
            'Phone Number', widget.restaurant.phoneNum),
      ],
    );
  }

  Card restaurantInfoCard(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
