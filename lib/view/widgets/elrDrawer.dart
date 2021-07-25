import 'package:elok_lagi_restaurant/view/authenticate/signinup.dart';
import 'package:elok_lagi_restaurant/view/screen/setting.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/controller/auth.dart';
import 'package:elok_lagi_restaurant/view/screen/faq/faq_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/order_list.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/profile.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/menu.dart';

class ElrDrawer extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: kToolbarHeight),
      color: colorsConst[50],
      child: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            drawerListTile(context, Icons.settings, 'SETTINGS', Setting()),
            divider(),
            drawerListTile(context, Icons.person, 'PROFILE', Profile()),
            divider(),
            drawerListTile(context, Icons.list, 'ORDER', OrderList()),
            divider(),
            drawerListTile(context, Icons.history, 'HISTORY', History()),
            divider(),
            drawerListTile(context, Icons.fastfood, 'MENU', Menu()),
            divider(),
            drawerListTile(context, Icons.chat, 'FAQ', FAQList()),
            divider(),
            drawerListTile(context, Icons.bar_chart, 'DASHBOARD', null),
            divider(),
            ListTile(
              onTap: () async {
                _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInUp()),
                );
              },
              tileColor: colorsConst[200],
              leading: Icon(Icons.logout, color: colorsConst[800]),
              title: Text(
                'LOGOUT',
                style: TextStyle(
                  color: colorsConst[800],
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
            ),
            divider(),
          ],
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(height: 20);
  }

  ListTile drawerListTile(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      tileColor: colorsConst[200],
      leading: Icon(icon, color: colorsConst[800]),
      title: Text(
        title,
        style: TextStyle(
          color: colorsConst[800],
          fontWeight: FontWeight.w800,
          fontSize: 25,
        ),
      ),
    );
  }
}
