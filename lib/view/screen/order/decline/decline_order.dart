import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/decline.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/screen/order/decline/decline_food.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/screen/order/customer_order.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class DeclineOrder extends StatefulWidget {
  final String did;
  DeclineOrder({this.did});

  @override
  _DeclineOrderState createState() => _DeclineOrderState();
}

class _DeclineOrderState extends State<DeclineOrder> {
  final _formKey = GlobalKey<FormState>();
  String _reason = '';

  final List<String> reason = [
    'Food item(s) no longer available',
    'Restaurant has closed',
    'Unresponsive customer',
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Decline>(
        stream: DatabaseService(uid: user.uid, fid: widget.did).declineData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Decline decline = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('#${decline.oid}'),
              ),
              body: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      declineReasonDropDown(),
                      Expanded(
                          flex: 2, child: CustomerOrder(cuid: decline.cuid)),
                      divider(),
                      Expanded(flex: 4, child: DeclineFood(oid: decline.oid)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            decline.message == ''
                                                ? 'No special request'
                                                : decline.message,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              orderColumn(decline, Icons.payment,
                                  'Total price: RM ${decline.totalPrice.toStringAsFixed(2)}'),
                              SizedBox(height: 5),
                              orderColumn(decline, Icons.access_time,
                                  'Pick Up Time: ${decline.pickUpTime}'),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DatabaseService(
                                          uid: user.uid,
                                          cuid: decline.cuid,
                                          fid: decline.oid)
                                      .createHistoryFromDecline(_reason);

                                      await DatabaseService(uid: user.uid)
                              .updateDashboard();

                                  Navigator.pop(context);
                                }
                              },
                              child: buttonTextRow(
                                  Icons.check_circle, 'CONFIRM DECLINE'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Padding declineReasonDropDown() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: DropdownButtonFormField(
        decoration: textInputDecoration(Icons.access_time, null).copyWith(),
        hint: Text('Please select a reason for decline'),
        items: reason.map((r) {
          return DropdownMenuItem(
            value: r,
            child: Text(r),
          );
        }).toList(),
        validator: (val) {
          String error;
          if (val == null) {
            return 'Choose reason to decline';
          }
          return error;
        },
        onChanged: (val) {
          setState(() {
            _reason = val;
          });
        },
      ),
    );
  }

  Row orderColumn(Decline decline, IconData icon, String info) {
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
