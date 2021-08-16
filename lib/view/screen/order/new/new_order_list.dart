import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/order.dart';
import 'package:elok_lagi_restaurant/view/screen/order/accept/accept_order.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_order.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:elok_lagi_restaurant/view/screen/order/food_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewOrderList extends StatefulWidget {
  @override
  _NewOrderListState createState() => _NewOrderListState();
}

class _NewOrderListState extends State<NewOrderList> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<Order>>(context);
    return order.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'There are no new orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: order.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => acceptProfileBottomSheet(context, order, index),
                child: Card(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListTile(
                    title: Text(order[index].oid,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(order[index].pickUpTime,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 18)),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              );
            },
          );
  }

  Future acceptProfileBottomSheet(
      BuildContext context, List<Order> order, int index) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Column(
            children: [
              Text('Accept this order?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Order ID: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                        Text(order[index].oid,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontSize: 17)),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Pick Up Time: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      Text(order[index].pickUpTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              fontSize: 17))
                    ]),
                    SizedBox(height: 10),
                    FoodOrder(oid: order[index].oid),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: elevatedButtonStyle().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: buttonTextRow(Icons.check_circle, 'ACCEPT'),
                    onPressed: () async {
                      await DatabaseService(
                              uid: order[index].ruid,
                              cuid: order[index].cuid,
                              fid: order[index].oid)
                          .createAccept();

                      await Navigator.popAndPushNamed(context, '/AcceptOrder',
                          arguments: {'aid': order[index].oid});
                    },
                  ),
                  ElevatedButton(
                    style: elevatedButtonStyle().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    child: buttonTextRow(Icons.cancel, 'DECLINE'),
                    onPressed: () async {
                      await DatabaseService(
                              uid: order[index].ruid,
                              cuid: order[index].cuid,
                              fid: order[index].oid)
                          .createDecline();

                      await Navigator.popAndPushNamed(context, '/DeclineOrder',
                          arguments: {'did': order[index].oid});
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
