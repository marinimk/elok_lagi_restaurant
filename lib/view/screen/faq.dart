// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'dart:math' as math;

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        //color: Colors.pink,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment(0, 0),
                color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    'How do I set up Elok Lagi Merchants?',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerRight,
                color: Colors.pink,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  // alignment: Alignment.center,
                  child: Text(
                    'You can search for the full tutorial on YouTube. The channel is Elok Lagi',
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
