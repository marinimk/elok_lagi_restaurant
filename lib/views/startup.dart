import 'package:elok_lagi_restaurant/views/history.dart';
import 'package:elok_lagi_restaurant/views/menu.dart';
import 'package:elok_lagi_restaurant/views/order.dart';
import 'package:flutter/material.dart';

class Startup extends StatefulWidget {
  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  Widget buildOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 15),
      //symmetric(horizontal: 30, vertical: 30),
      //width: double.infinity,
      // color: Colors.black,
      child: ElevatedButton(
        child: Text(
          'ORDER',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          minimumSize: Size(200, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          print('ORDER Pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Order()),
          );
        },
      ),
    );
  }

  Widget buildHistory() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      //symmetric(horizontal: 30, vertical: 30),
      // width: double.infinity,
      // color: Colors.black,
      child: ElevatedButton(
        child: Text(
          'HISTORY',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          minimumSize: Size(200, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          print('HISTORY Pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => History()),
          );
        },
      ),
    );
  }

  Widget buildMenu() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      //symmetric(horizontal: 30, vertical: 30),
      // width: double.infinity,
      // color: Colors.black,
      child: ElevatedButton(
        child: Text(
          'MENU',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          minimumSize: Size(200, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          print('MENU Pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Menu()),
          );
        },
      ),
    );
  }

  Widget buildFAQ() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 30),
      //symmetric(horizontal: 30, vertical: 30),
      // width: double.infinity,
      // color: Colors.black,
      child: ElevatedButton(
        child: Text(
          'FAQ',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          primary: Colors.white,
          minimumSize: Size(200, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          print('FAQ Pressed');
          // Navigator.push(
          //   );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MERCHANT\'S APP'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: buildElevatedButton(),
          ),
        ],
      ),
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
              buildOrder(),
              buildHistory(),
              buildMenu(),
              buildFAQ(),
            ],
          ),
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
}
