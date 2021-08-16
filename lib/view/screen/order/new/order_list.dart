import 'dart:ui';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/order.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:elok_lagi_restaurant/view/screen/order/new/new_order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return loading
        ? Loading()
        : StreamProvider<List<Order>>.value(
            value: DatabaseService(uid: user.uid).order,
            initialData: [],
            child: Scaffold(
              drawer: ElrDrawer(),
              appBar: ElrAppBar('Order', false),
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
                          child: Text('New Order',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                    ),
                    Expanded(
                        flex: 15,
                        child: Container(height: 500, child: NewOrderList())),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          );
  }
}
