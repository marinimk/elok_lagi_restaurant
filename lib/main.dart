import 'package:elok_lagi_restaurant/views/order.dart';
import 'package:elok_lagi_restaurant/views/startup.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  static const bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('korvet korvet'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
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
            ),
          ),
        ],
      ),
      body: new Startup(),
    );
  }
}
