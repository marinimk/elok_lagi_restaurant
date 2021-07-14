import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantTile({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        restaurantInfoCard(
            context, Icons.person_outline, 'Name', restaurant.name),
        restaurantInfoCard(
            context, Icons.email_outlined, 'Email', restaurant.email),
        restaurantInfoCard(
            context, Icons.lock_outline, 'Password', restaurant.password),
        restaurantInfoCard(
            context, Icons.pin_drop_outlined, 'Location', restaurant.location),
        restaurantInfoCard(context, Icons.phone_android_outlined,
            'Phone Number', restaurant.phoneNum),
          
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
