import 'package:elok_lagi_restaurant/models/decline.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_order.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DeclineOrderList extends StatefulWidget {
  @override
  _DeclineOrderListState createState() => _DeclineOrderListState();
}

class _DeclineOrderListState extends State<DeclineOrderList> {
  @override
  Widget build(BuildContext context) {
    final decline = Provider.of<List<Decline>>(context);
    return decline.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'There are no declined orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: decline.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: DeclineOrder(did: decline[index].did),
                  )),
                child: Card(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListTile(
                    title: Text(
                      decline[index].oid,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(decline[index].pickUpTime,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 18)),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          );
  }
}
