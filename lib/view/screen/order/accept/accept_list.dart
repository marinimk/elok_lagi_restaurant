import 'dart:ui';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/accept.dart';
import 'package:elok_lagi_restaurant/models/decline.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_order_list.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptList extends StatefulWidget {
  @override
  _AcceptList createState() => _AcceptList();
}

class _AcceptList extends State<AcceptList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return loading
        ? Loading()
        : StreamProvider<List<Accept>>.value(
            value: DatabaseService(uid: user.uid).accept,
            initialData: [],
            child: Scaffold(
              drawer: ElrDrawer(),
              appBar: ElrAppBar('ACCEPTED', false),
              body: Container(
                padding: EdgeInsets.all(5),
                color: colorsConst[50],
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Order Accepted',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                    ),
                    Expanded(
                        flex: 15,
                        child:
                            Container(height: 500, child: AcceptOrderList())),
                  ],
                ),
              ),
            ),
          );
  }
}
