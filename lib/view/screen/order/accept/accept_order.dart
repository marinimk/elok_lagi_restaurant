import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/accept.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_food.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/order_ready.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/screen/order/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptOrder extends StatefulWidget {
  final String aid;
  AcceptOrder({this.aid});

  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Accept>(
        stream: DatabaseService(uid: user.uid, fid: widget.aid).acceptData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Accept accept = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('#${accept.oid}'),
              ),
              body: Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider(),
                    Expanded(flex: 2, child: CustomerOrder(cuid: accept.cuid)),
                    divider(),
                    Expanded(flex: 5, child: AcceptFood(oid: accept.oid)),
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
                                          accept.message == ''
                                              ? 'No special request'
                                              : accept.message,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            orderColumn(accept, Icons.payment,
                                'Total price: RM ${accept.totalPrice.toStringAsFixed(2)}'),
                            SizedBox(height: 5),
                            orderColumn(accept, Icons.access_time,
                                'Pick Up Time: ${accept.pickUpTime}'),
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
                          ElevatedButton(
                            style: elevatedButtonStyle().copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async {
                              // await DatabaseService(
                              //         uid: widget.cuid, fid: widget.oid)
                              //     .readyOrder();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderReady(accept: accept)),
                              );
                            },
                            child: buttonTextRow(Icons.check_circle, 'READY'),
                          ),
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

  Row orderColumn(Accept accept, IconData icon, String info) {
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
