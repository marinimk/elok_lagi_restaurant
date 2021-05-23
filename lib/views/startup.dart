import 'package:flutter/material.dart';

class Startup extends StatefulWidget {
  @override
  _StartupState createState() => _StartupState();
}

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
        // Navigator.push(
        //   );
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
        // Navigator.push(
        //   );
      },
    ),
  );
}

Widget buildSettings() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    //symmetric(horizontal: 30, vertical: 30),
    // width: double.infinity,
    // color: Colors.black,
    child: ElevatedButton(
      child: Text(
        'SETTINGS',
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
        print('SETTINGS Pressed');
        // Navigator.push(
        //   );
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

class _StartupState extends State<Startup> {
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
              buildOrder(),
              buildHistory(),
              buildSettings(),
              buildFAQ()
            ],
          ),
        ),
      ),
    );
  }
}
