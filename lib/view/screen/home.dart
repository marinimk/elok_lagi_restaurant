import 'package:elok_lagi_restaurant/models/restaurant.dart';
// import 'package:elok_lagi_restaurant/screens/home/restaurant_list.dart';
import 'package:elok_lagi_restaurant/services/auth.dart';
import 'package:elok_lagi_restaurant/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi_restaurant/view/widgets/restaurant_list.dart';
import 'package:elok_lagi_restaurant/models/users.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Restaurant>>.value(
      initialData: [],
      value: DatabaseService().restaurant,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Elok Lagi Merchant'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.person),
            //   onPressed: DatabaseService(uid:FQoFFESSZqW4axuJT7u4Y3beb9x1),
            // ),
          ],
        ),
        body: RestaurantList(),
      ),
    );
  }
}
