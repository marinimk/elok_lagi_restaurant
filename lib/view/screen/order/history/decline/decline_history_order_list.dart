import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/decline/decline_history_order.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DeclineHistoryOrderList extends StatefulWidget {
  @override
  _DeclineHistoryOrderListState createState() =>
      _DeclineHistoryOrderListState();
}

class _DeclineHistoryOrderListState extends State<DeclineHistoryOrderList> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<List<DeclineHistory>>(context);
    return history.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'There are no new declined orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DeclineHistoryOrder(
                          history[index].dhid, history[index].cuid),
                    )),
                // MaterialPageRoute(
                //     builder: (context) => DeclineHistoryOrder(
                //         history[index].dhid, history[index].cuid))),
                child: Card(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                history[index].accepted
                                    ? 'ACCEPTED'
                                    : 'DECLINED',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: history[index].accepted
                                      ? Colors.green
                                      : Colors.red,
                                  backgroundColor: history[index].accepted
                                      ? Colors.green[50]
                                      : Colors.red[50],
                                )),
                            SizedBox(height: 2),
                            Text(history[index].dhid,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 2),
                            Text(
                                '${history[index].date} ${history[index].pickUpTime}',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18)),
                          ],
                        ),
                        Icon(Icons.chevron_right, color: Colors.black45),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
