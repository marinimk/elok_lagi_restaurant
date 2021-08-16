import 'package:elok_lagi_restaurant/models/accept.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_order.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AcceptOrderList extends StatefulWidget {
  @override
  _AcceptOrderListState createState() => _AcceptOrderListState();
}

class _AcceptOrderListState extends State<AcceptOrderList> {
  @override
  Widget build(BuildContext context) {
    final accept = Provider.of<List<Accept>>(context);
    return accept.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'There are no accepted orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: accept.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: AcceptOrder(aid: accept[index].aid),
                  )),
                    // MaterialPageRoute(
                    //     builder: (context) =>
                    //         )),
                child: Card(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListTile(
                    title: Text(
                      accept[index].oid,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(accept[index].pickUpTime,
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
