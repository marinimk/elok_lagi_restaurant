import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi_restaurant/models/food.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String uid;
  DatabaseService({@required this.uid});

  // collection reference
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');
  final CollectionReference foodCollection = FirebaseFirestore.instance
      .collection('restaurant')
      .doc()
      .collection('food');

  Future updateRestaurantData(
      String name, String location, String phoneNum, bool status) async {
    return await restaurantCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      // 'email': email,
      // 'password': password,
      'location': location,
      'phoneNum': phoneNum,
      'status': status,
    });
  }

  Future updateFoodData(String description, String name, double oriPrice,
      double salePrice, int pax) async {
    return await restaurantCollection.doc(uid).collection('food').doc().set({
      'ruid': uid,
      'name': name,
      'description': description,
      'oriPrice': oriPrice,
      'salePrice': salePrice,
      'pax': pax,
    });
  }

  List<Restaurant> _restaurantListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Restaurant(
        name: doc.data()['name'] ?? '',
        // email: doc.data()['email'] ?? '',
        // password: doc.data()['password'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
        status: doc.data()['status'] ?? false,
      );
    }).toList();
  }

  RestaurantData _restaurantDataFromSS(DocumentSnapshot snapshot) {
    return RestaurantData(
      uid: uid,
      name: snapshot.data()['name'] ?? '',
      // email: snapshot.data()['email'] ?? '',
      // password: snapshot.data()['password'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
      status: snapshot.data()['status'] ?? false,
    );
  }

  List<Food> _foodListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Food(
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? '',
        oriPrice: doc.data()['oriPrice'] ?? 0.0,
        salePrice: doc.data()['salePrice'] ?? 0.0,
        pax: doc.data()['pax'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Restaurant>> get restaurant {
    return restaurantCollection.snapshots().map(_restaurantListFromSS);
  }

  Stream<RestaurantData> get restaurantData {
    return restaurantCollection.doc(uid).snapshots().map(_restaurantDataFromSS);
  }

  Stream<List<Food>> get food {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .snapshots()
        .map(_foodListFromSS);
  }
}
