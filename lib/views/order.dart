import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  @override
  _Order createState() => _Order();
}

//int count = 1;

Widget buildNewTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'New',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buildCardAcahTry(int count) {
  return Card(
    child: ListTile(
      title: Text(
        'Order #' + count.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      trailing: Text(
        '16:00',
        style: TextStyle(
            // fontWeight: FontWeight.bold,
            // fontSize: 18,
            ),
      ),
    ),
  );
  //count = count + 1;
}

Widget buildCardNewOrder() {
  return Expanded(
    child: Container(
      width: double.infinity,
      color: Colors.amber,
      child: ListView(
        children: [
          buildCardAcahTry(1),
          buildCardAcahTry(2),
          buildCardAcahTry(3),
          buildCardAcahTry(4),
          buildCardAcahTry(5),
        ],
      ),
    ),
  );
}

Widget buildCurrTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'Current',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buildCardCurrOrder() {
  return Expanded(
    child: Container(
      width: double.infinity,
      color: Colors.blue,
      child: ListView(
        children: [
          buildCardAcahTry(1),
          buildCardAcahTry(2),
        ],
      ),
    ),
  );
}

class _Order extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        color: Color(0xffE8E8E8),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          //mainAxisSize: ,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildNewTitle(),
            buildCardNewOrder(),
            SizedBox(
              height: 0,
            ),
            buildCurrTitle(),
            buildCardCurrOrder(),
          ],
        ),
      ),
    );
  }
}
