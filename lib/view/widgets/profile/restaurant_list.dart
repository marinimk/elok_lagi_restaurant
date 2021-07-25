import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/view/widgets/profile/restaurant_tile.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    final restaurantData = Provider.of<RestaurantData>(context);

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return RestaurantTile(restaurant: restaurantData);
      },
    );
  }
}
