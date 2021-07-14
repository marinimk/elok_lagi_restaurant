// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');

  Future updateRestaurantData(String name, String email, String password,
      String location, String phoneNum) async {
    return await restaurantCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'location': location,
      'phoneNum': phoneNum,
    });
  }

  List<Restaurant> _restaurantListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Restaurant(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        password: doc.data()['password'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
      );
    }).toList();
  }

  Stream<List<Restaurant>> get restaurant {
    return restaurantCollection.snapshots()
    .map(_restaurantListFromSS);
  }
  // Stream<Restaurant> get restaurant {
  //   return restaurantCollection.snapshots()
  //   .map(_restaurantListFromSS);
  // }

  void getRestaurant() async {
    final restaurant = await restaurantCollection.get();
    for (var rest in restaurant.docs) {
      print(rest.data);
    }
  }
}
