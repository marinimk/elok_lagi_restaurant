import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/accept/accept_history_food.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/accept/view_feedback.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/screen/order/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class AcceptHistoryOrder extends StatefulWidget {
  final String hid;
  final String cuid;
  AcceptHistoryOrder(this.hid, this.cuid);

  @override
  _AcceptHistoryOrderState createState() => _AcceptHistoryOrderState();
}

class _AcceptHistoryOrderState extends State<AcceptHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<AcceptHistory>(
        stream:
            DatabaseService(uid: user.uid, fid: widget.hid).acceptHistoryData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AcceptHistory history = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('#${history.ahid}'),
              ),
              body: Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider(),
                    Expanded(flex: 2, child: CustomerOrder(cuid: history.cuid)),
                    divider(),
                    Expanded(
                        flex: 5, child: AcceptHistoryFood(hid: history.ahid)),
                    divider(),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.border_color, size: 30),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Special request: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      width: 275,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                          history.message == ''
                                              ? 'No special request'
                                              : history.message,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            orderColumn(history, Icons.payment,
                                'Total price: RM ${history.totalPrice.toStringAsFixed(2)}'),
                            SizedBox(height: 5),
                            orderColumn(history, Icons.access_time,
                                'Pick Up Time: ${history.pickUpTime}'),
                          ],
                        ),
                      ),
                    ),
                    divider(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          history.completed
                              ? ElevatedButton(
                                  style: elevatedButtonStyle().copyWith(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                  ),
                                  onPressed: () async =>
                                      viewFeedback(context, history),
                                  child: buttonTextRow(
                                      Icons.check_circle, 'VIEW FEEDBACK'),
                                )
                              : Container(),
                        ],
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

  Row orderColumn(AcceptHistory history, IconData icon, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 30),
        SizedBox(width: 10),
        Text(info, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Divider divider() {
    return Divider(thickness: 1, height: 1);
  }

  Future viewFeedback(BuildContext context, AcceptHistory history) {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: colorsConst[100],
                    border: Border.all(width: 5, color: colorsConst[300]),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 375,
                width: 350,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'View your Feedback',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  ViewFeedback(
                    ruid: history.ruid,
                    fid: history.ahid,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
