// import 'dart:js';

// import 'package:elok_lagi_restaurant/views/order.dart';
import 'package:elok_lagi_restaurant/views/startup.dart';
// import 'package:elok_lagi_restaurant/utils/appbar.dart';
import 'package:flutter/material.dart';

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
class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MERCHANT\'S APP'),
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       child: buildElevatedButton(),
      //     ),
      //   ],
      // ),
      body: new Startup(),
    );
  }

  // ElevatedButton buildElevatedButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // buildShowAlert(context);
  //     },
  //     child: Row(
  //       children: <Widget>[
  //         Icon(
  //           Icons.fiber_manual_record,
  //           size: 15,
  //           color: Colors.green,
  //         ),
  //         SizedBox(
  //           width: 5,
  //         ),
  //         Text(
  //           'OPEN',
  //         ),
  //       ],
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       primary: Colors.black,
  //     ),
  //   );
  // }

  // buildShowAlert(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Center(child: Text('Your restaurant is Open')),
  //         // titlePadding: EdgeInsets.fromWindowPadding(padding, devicePixelRatio),
  //         content: Text('Do you want to change your status?'),
  //         actions: [
  //           OutlinedButton(
  //             onPressed: () {},
  //             child: Row(children: [
  //               Icon(
  //                 Icons.fiber_manual_record,
  //                 size: 15,
  //                 color: Colors.red,
  //               ),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Text(
  //                 'Close',
  //                 style: TextStyle(
  //                   color: Colors.red,
  //                 ),
  //               ),
  //             ]),
  //             style: OutlinedButton.styleFrom(
  //               side: BorderSide(
  //                 width: 1.5,
  //               ),
  //               // backgroundColor: Colors.black,
  //             ),
  //           ),
  //           OutlinedButton(
  //             onPressed: () {},
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   Icons.fiber_manual_record,
  //                   size: 15,
  //                   color: Colors.amber,
  //                 ),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Text(
  //                   'Busy',
  //                   style: TextStyle(
  //                     color: Colors.amber,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             style: OutlinedButton.styleFrom(
  //               side: BorderSide(
  //                 width: 1.5,
  //               ),
  //               // backgroundColor: Colors.black,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
