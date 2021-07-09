import 'package:elok_lagi_restaurant/view/authenticate/signin.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elok_lagi_restaurant/services/auth.dart';
import 'package:elok_lagi_restaurant/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<Restaurants>.value(
      initialData: Restaurants(),
      value: AuthService().restaurant,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}