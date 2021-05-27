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

ElevatedButton buildElevatedButton() {
  return ElevatedButton(
    onPressed: () {
      // buildShowAlert(context);
    },
    child: Row(
      children: <Widget>[
        Icon(
          Icons.fiber_manual_record,
          size: 15,
          color: Colors.green,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'OPEN',
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
    ),
  );
}

buildShowAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text('Your restaurant is Open')),
        // titlePadding: EdgeInsets.fromWindowPadding(padding, devicePixelRatio),
        content: Text('Do you want to change your status?'),
        actions: [
          OutlinedButton(
            onPressed: () {},
            child: Row(children: [
              Icon(
                Icons.fiber_manual_record,
                size: 15,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Close',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ]),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1.5,
              ),
              // backgroundColor: Colors.black,
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  size: 15,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Busy',
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1.5,
              ),
              // backgroundColor: Colors.black,
            ),
          ),
        ],
      );
    },
  );
}

class _Order extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ORDER'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: buildElevatedButton(),
          ),
        ],
      ),
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
