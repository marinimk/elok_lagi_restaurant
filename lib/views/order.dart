import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  @override
  _Order createState() => _Order();
}

Widget buildCardNewOrder() {
  return Card(
    child: ListTile(
      title: Text("bitch"),
    ),
    color: Colors.blue,
  );
  // return Card(
  //   child: ListTile(
  //     leading: FlutterLogo(size: 56.0),
  //     title: Text('Two-line ListTile'),
  //     subtitle: Text('Here is a second line'),
  //     trailing: Icon(Icons.more_vert),
  //   ),
  // );
}

Widget buildCardCurrOrder() {
  return Card(
    child: ListTile(
      leading: FlutterLogo(size: 56.0),
      title: Text('Two-line ListTile'),
      subtitle: Text('Here is a second line'),
      trailing: Icon(Icons.more_vert),
    ),
  );
}

class _Order extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            //mainAxisSize: ,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCardNewOrder(),
              buildCardCurrOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
