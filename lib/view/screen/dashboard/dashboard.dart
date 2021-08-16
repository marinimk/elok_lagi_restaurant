import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardData extends StatefulWidget {
  @override
  _DashboardDataState createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  // int _accepted = 0;
  // int _declined = 0;
  // double _sales = 0.0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Dashboard>(
        stream: DatabaseService(uid: user.uid).dashboard,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Dashboard dashboard = snapshot.data;
            return Scaffold(
              appBar: ElrAppBar('DASHBOARD', false),
              drawer: ElrDrawer(),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        dashboardCard(
                            Icons.check_circle_outline,
                            'NUMBER OF ACEPTED ORDERS',
                            dashboard.accept.toString(),
                            Colors.blue[100],
                            Colors.blue[400]),
                        dashboardCard(
                            Icons.cancel_outlined,
                            'NUMBER OF DECLINED ORDERS',
                            dashboard.decline.toString(),
                            Colors.red[100],
                            Colors.red[400]),
                      ],
                    ),
                    Card(
                      color: Colors.purple[100],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.purple[400]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_money, size: 50),
                            Text(
                              'TOTAL SALES MADE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'RM ${dashboard.sales.toStringAsFixed(2).toString()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Expanded dashboardCard(IconData icon, String title, String info,
      Color cardColor, Color borderColor) {
    return Expanded(
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
