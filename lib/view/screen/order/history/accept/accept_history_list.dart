import 'dart:ui';
import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/accept/accept_history_order_list.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_appbar.dart';
import 'package:elok_lagi_restaurant/view/widgets/elr_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptHistoryList extends StatefulWidget {
  @override
  _HistoryList createState() => _HistoryList();
}

class _HistoryList extends State<AcceptHistoryList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return loading
        ? Loading()
        : StreamProvider<List<AcceptHistory>>.value(
            value: DatabaseService(uid: user.uid).acceptHistory,
            initialData: [],
            child: Expanded(
                flex: 15,
                child:
                    Container(height: 500, child: AcceptHistoryOrderList())));
  }
}
