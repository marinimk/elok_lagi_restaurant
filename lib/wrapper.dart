// import 'package:elok_lagi/master.dart';
// import 'package:elok_lagi_restaurant/view/widgets/elrAppBar.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/authenticate/authenticate.dart';
// import 'package:elok_lagi_restaurant/view/screen/profile/profile.dart';
// import 'package:elok_lagi_restaurant/view/screen/order/order.dart';
// import 'package:elok_lagi/screens/home.dart';
// import 'package:elok_lagi_restaurant/view/authenticate/signinup.dart';
import 'package:elok_lagi_restaurant/view/screen/startup.dart';
// import 'package:elok_lagi_restaurant/view/widgets/elrDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      // return Master();
      return Startup();
      // return ElrDrawer();
      // return Profile();
    }
  }
}
