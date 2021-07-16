import 'package:elok_lagi_restaurant/models/users.dart';
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
    return StreamProvider<Users>.value(
      initialData: Users(),
      value: AuthService().restaurant,
      child: MaterialApp(
        theme: ThemeData(
          canvasColor: Color(0xffF3F7F2),
          primarySwatch: MaterialColor(
            0xff76a973,
            const <int, Color>{
              50: const Color(0xffF3F7F2), //10%
              100: const Color(0xffDAE8D9), //20%
              200: const Color(0xffC1D8C0), //30%
              300: const Color(0xffA8C9A6), //40%
              400: const Color(0xff8FB98D), //50%
              500: const Color(0xff76a973), //60%
              600: const Color(0xff60985D), //70%
              700: const Color(0xff507E4E), //80%
              800: const Color(0xff3F653E), //90%
              900: const Color(0xff2F4C2F), //100%
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
