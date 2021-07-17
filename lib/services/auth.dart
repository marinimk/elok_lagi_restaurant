import 'package:elok_lagi_restaurant/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elok_lagi_restaurant/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User restaurant) {
    return restaurant != null ? Users(uid: restaurant.uid) : null;
  }

  // auth change user stream
  Stream<Users> get restaurant {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User restaurant = result.user;
      return _userFromFirebaseUser(restaurant);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User restaurant = result.user;
      return restaurant;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User restaurant = result.user;
      await DatabaseService(uid: restaurant.uid)
          .updateRestaurantData('name', 'location', 'phoneNum', false);
      await DatabaseService(uid: restaurant.uid)
          .updateFoodData('description', 'marini', 0.0, 0.0, 0);
      return _userFromFirebaseUser(restaurant);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
