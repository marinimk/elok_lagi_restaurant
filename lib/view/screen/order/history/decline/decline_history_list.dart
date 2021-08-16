import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/decline/decline_history_order_list.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeclineHistoryList extends StatefulWidget {
  @override
  _HistoryList createState() => _HistoryList();
}

class _HistoryList extends State<DeclineHistoryList> {
  bool loading = false; 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return loading
        ? Loading()
        : StreamProvider<List<DeclineHistory>>.value(
            value: DatabaseService(uid: user.uid).declineHistory,
            initialData: [],
            child: Expanded(
                flex: 15,
                child:
                    Container(height: 500, child: DeclineHistoryOrderList())));
  }
}
