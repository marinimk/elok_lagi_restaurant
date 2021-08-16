import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/history.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history/decline/decline_history_food.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/screen/order/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class DeclineHistoryOrder extends StatefulWidget {
  final String hid;
  final String cuid;
  DeclineHistoryOrder(this.hid, this.cuid);

  @override
  _DeclineHistoryOrderState createState() => _DeclineHistoryOrderState();
}

class _DeclineHistoryOrderState extends State<DeclineHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<DeclineHistory>(
        stream:
            DatabaseService(uid: user.uid, fid: widget.hid).declineHistoryData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DeclineHistory history = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('#${history.dhid}'),
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
                        flex: 5, child: DeclineHistoryFood(hid: history.dhid)),
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
                      child: history.accepted
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                history.completed
                                    ? Container()
                                    : ElevatedButton(
                                        style: elevatedButtonStyle().copyWith(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                        ),
                                        onPressed: () async {
                                          await DatabaseService(
                                                  uid: user.uid,
                                                  cuid: widget.cuid,
                                                  fid: widget.hid)
                                              .completeOrder();

                                          Navigator.pop(context);
                                        },
                                        child: buttonTextRow(
                                            Icons.check_circle, 'COMPLETED'),
                                      ),
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              margin: EdgeInsets.fromLTRB(35, 10, 35, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.error_outline, size: 30),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Order cancelled due to',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(history.reason,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal)),
                                    ],
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

  Row orderColumn(DeclineHistory history, IconData icon, String info) {
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
}
