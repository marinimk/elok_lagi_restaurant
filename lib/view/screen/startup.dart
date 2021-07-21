import 'package:elok_lagi_restaurant/view/screen/profile/profile.dart';
import 'package:elok_lagi_restaurant/view/widgets/elrAppBar.dart';
import 'package:elok_lagi_restaurant/view/screen/faq/faq.dart';
import 'package:elok_lagi_restaurant/view/screen/order/history.dart';
import 'package:elok_lagi_restaurant/view/screen/menu/menu.dart';
import 'package:elok_lagi_restaurant/view/screen/order/order.dart';
import 'package:flutter/material.dart';

class Startup extends StatefulWidget {
  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ElrAppBar('EL MERCHANT\'S APP', false),
      appBar: ElrAppBar('EL MERCHANT\'S APP', false),
      // drawer: ElrDrawer(),
      body: Container(
        color: Color(0xffFDF7FA),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            //mainAxisSize: ,
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  startUpCard(Icons.person, 'Profile', Profile()),
                  startUpCard(Icons.list, 'Order', Order()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  startUpCard(Icons.history, 'History', History()),
                  startUpCard(Icons.fastfood, 'Menu', Menu()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  startUpCard(Icons.chat, 'FAQ', FAQ()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget startUpCard(IconData icon, String title, Widget page) {
    return Container(
      // color:Colors.pink,
      padding: EdgeInsets.all(15),
      child: ElevatedButton(
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: Color(0xffF3F7F2),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: Color(0xffF3F7F2),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          // elevation: 5.0,
          primary: Color(0xff2F4C2F),
          minimumSize: Size(150, 150),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        buildShowAlert(context);
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(children: [
                Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Cancel',
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
