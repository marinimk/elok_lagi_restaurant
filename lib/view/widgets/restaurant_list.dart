import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:elok_lagi_restaurant/view/widgets/restaurant_tile.dart';

class RestaurantList extends StatefulWidget {
  // RestaurantList(String title, String sub);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<List<Restaurant>>(context);

    return ListView.builder(
      itemCount: restaurant.length,
      itemBuilder: (context, index) {
        return RestaurantTile(restaurant: restaurant[index]);
      },
    );
  }
}
