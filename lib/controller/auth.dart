import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elok_lagi_restaurant/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
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
      User user = result.user;
      await DatabaseService(uid: user.uid).updateRestaurantData(
          'name',
          'category',
          'location',
          'phoneNum',
          false,
          'https://firebasestorage.googleapis.com/v0/b/elok-lagi.appspot.com/o/dafultUser.png?alt=media&token=d817ae55-f30c-47c6-bd75-30348e18eb73');
      // await DatabaseService(uid: restaurant.uid)
      //     .updateFoodData('description', 'marini', 0.0, 0.0, 0);
      return _userFromFirebaseUser(user);
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
