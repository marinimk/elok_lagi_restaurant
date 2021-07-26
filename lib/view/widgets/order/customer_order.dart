import 'package:elok_lagi_restaurant/controller/database.dart';
import 'package:elok_lagi_restaurant/models/customer.dart';
import 'package:elok_lagi_restaurant/view/widgets/loading.dart';
import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';

class CustomerOrder extends StatelessWidget {
  final String cuid;
  CustomerOrder({this.cuid});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CustomerData>(
        stream: DatabaseService(uid: cuid).customerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final customer = snapshot.data;
            return Column(
              children: [
                customerInfo(
                    Icons.person, 'Customer\'s Name', customer.username),
                customerInfo(Icons.phone_android, 'Customer\'s Phone Number',
                    customer.phoneNum),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Container customerInfo(IconData icon, String title, String info) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                info.capitalizeFirstofEach,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
