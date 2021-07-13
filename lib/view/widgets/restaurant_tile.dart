import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantTile({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: Column(
            children: [
              restaurantInfoTile(Icons.person_outline, 'Name', restaurant.name),
              SizedBox(height: 10),
              restaurantInfoTile(
                  Icons.email_outlined, 'Email', restaurant.email),
              SizedBox(height: 10),
              restaurantInfoTile(
                  Icons.lock_outline, 'Password', restaurant.password),
              SizedBox(height: 10),
              restaurantInfoTile(
                  Icons.pin_drop_outlined, 'Location', restaurant.location),
              SizedBox(height: 10),
              restaurantInfoTile(
                  Icons.phone_outlined, 'Phone Number', restaurant.phoneNum),
            ],
          ),
        ),
      ],
    );
  }

  ListTile restaurantInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.create_outlined),
    );
  }
}
