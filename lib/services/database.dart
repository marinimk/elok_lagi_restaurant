import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi_restaurant/models/food.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');
  final CollectionReference foodCollection = FirebaseFirestore.instance
      .collection('restaurant')
      .doc()
      .collection('food');

  Future updateRestaurantData(String name, String email, String password,
      String location, String phoneNum, bool status) async {
    return await restaurantCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'location': location,
      'phoneNum': phoneNum,
      'status' : status,
    });
  }

  Future updateFoodData(String description, String name, double oriPrice,
      double salePrice, int pax) async {
    return await foodCollection.doc().set({
      'name': name,
      'description': description,
      'ori price': oriPrice,
      'sale price': salePrice,
      'pax': pax,
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
        status: doc.data()['status'] ?? '',
      );
    }).toList();
  }

  List<Food> _foodListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Food(
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? '',
        oriPrice: doc.data()['ori price'] ?? 0.0,
        salePrice: doc.data()['sale price'] ?? 0.0,
        pax: doc.data()['pax'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Restaurant>> get restaurant {
    return restaurantCollection.snapshots().map(_restaurantListFromSS);
  }

  Stream<List<Food>> get food {
    return foodCollection.snapshots().map(_foodListFromSS);
  }
}
