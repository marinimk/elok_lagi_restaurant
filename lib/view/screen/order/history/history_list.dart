import 'dart:ui';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/order.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/accept/accept_history_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/accept/accept_history_order_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/decline/decline_history_list.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/decline/decline_history_order_list.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryList createState() => _HistoryList();
}

class _HistoryList extends State<HistoryList> {
  bool loading = false;
  bool isAccept = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return loading
        ? Loading()
        : Scaffold(
            drawer: ElrDrawer(),
            appBar: ElrAppBar('HISTORY', false),
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
                        child: Text('Order History',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => isAccept = true);
                        },
                        child: Column(
                          children: [
                            Text(
                              "ACCEPTED",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isAccept
                                      ? Color(0xFF09126C)
                                      : Color(0XFFA7BCC7)),
                            ),
                            if (isAccept)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => isAccept = false);
                        },
                        child: Column(
                          children: [
                            Text(
                              "DECLINED",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isAccept
                                      ? Color(0xFF09126C)
                                      : Color(0XFFA7BCC7)),
                            ),
                            if (!isAccept)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isAccept)
                    Expanded(
                        flex: 15,
                        child:
                            Container(height: 500, child: AcceptHistoryList())),
                  if (!isAccept)
                    Expanded(
                        flex: 15,
                        child: Container(
                            height: 500, child: DeclineHistoryList())),
                ],
              ),
            ),
          );
  }
}
