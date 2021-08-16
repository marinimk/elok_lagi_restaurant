import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/accept.dart';
import 'package:elok_lagi_restaurant/models/users.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderReady extends StatelessWidget {
  final Accept accept;
  OrderReady({this.accept});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(title: Text('ORDER READY')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text('Order ${accept.oid} is now ready for pickup!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic))),
          Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                  'When the customer has arrived to pickup their order, update the progress of the order in the History tab in the sidebar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic))),
          Container(
            width: 251,
            child: ElevatedButton(
                onPressed: () async {
                  await DatabaseService(
                          uid: accept.ruid, cuid: accept.cuid, fid: accept.oid)
                      .createHistoryFromAccept();
                  await DatabaseService(uid: user.uid).updateDashboard();

                  Navigator.popAndPushNamed(context, '/AcceptList');
                },
                style: elevatedButtonStyle(),
                child: buttonTextRow(
                    Icons.keyboard_return, 'Return to Accepted screen')),
          )
        ],
      ),
    );
  }
}
