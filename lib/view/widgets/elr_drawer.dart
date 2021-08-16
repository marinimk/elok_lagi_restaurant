import 'package:elok_lagi_restaurant/view/authenticate/signinup.dart';
import 'package:elok_lagi_restaurant/view/screen/dashboard/dashboard.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_list.dart';
import 'package:elok_lagi_restaurant/view/screen/setting.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_list.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/controller/auth.dart';
import 'package:elok_lagi_restaurant/view/screen/faq/faq_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/new/order_list.dart';
import 'package:elok_lagi_restaurant/view/screen/profile/profile.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/history_list.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/menu.dart';
import 'package:page_transition/page_transition.dart';

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
            divider(),
            drawerListTile(
                context, Icons.settings_outlined, 'SETTINGS', Setting()),
            divider(),
            drawerListTile(context, Icons.person_outline, 'PROFILE', Profile()),
            divider(),
            drawerListTile(context, Icons.list, 'ORDER', OrderList()),
            divider(),
            drawerListTile(
                context, Icons.check_circle_outline, 'ACCEPT', AcceptList()),
            divider(),
            drawerListTile(
                context, Icons.cancel_outlined, 'DECLINE', DeclineList()),
            divider(),
            drawerListTile(context, Icons.history, 'HISTORY', HistoryList()),
            divider(),
            drawerListTile(context, Icons.fastfood_outlined, 'MENU', Menu()),
            divider(),
            drawerListTile(context, Icons.chat_outlined, 'FAQ', FAQList()),
            divider(),
            drawerListTile(
                context, Icons.bar_chart, 'DASHBOARD', DashboardData()),
            divider(),
            ListTile(
              onTap: () async {
                _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: SignInUp()));
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
    return Divider(height: 5, thickness: 5, color: colorsConst[800]);
  }

  ListTile drawerListTile(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: page),
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
