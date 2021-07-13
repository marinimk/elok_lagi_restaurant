// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class MyAppBar extends PreferredSize {
  // final Widget child;
  // final double height;
  // final Color color;

  MyAppBar();

  @override
  // Size get preferedSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('korvet korvet'),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: buildElevatedButton(),
        ),
      ],
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

// class MyAppBar extends StatefulWidget{
//   @override
//   _MyAppBarState createState() => _MyAppBarState();
// }

// class _MyAppBarState extends State<MyAppBar>{
//   @override
//   // Size get prefferedSize => Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text('korvet korvet'),
//       actions: <Widget>[
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: buildElevatedButton(),
//         ),
//       ],
//     );
//   }

//   ElevatedButton buildElevatedButton() {
//     return ElevatedButton(
//       onPressed: () {
//         buildShowAlert(context);
//       },
//       child: Row(
//         children: <Widget>[
//           Icon(
//             Icons.fiber_manual_record,
//             size: 15,
//             color: Colors.green,
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Text(
//             'OPEN',
//           ),
//         ],
//       ),
//       style: ElevatedButton.styleFrom(
//         primary: Colors.black,
//       ),
//     );
//   }

//   buildShowAlert(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Center(child: Text('Your restaurant is Open')),
//           // titlePadding: EdgeInsets.fromWindowPadding(padding, devicePixelRatio),
//           content: Text('Do you want to change your status?'),
//           actions: [
//             OutlinedButton(
//               onPressed: () {},
//               child: Row(children: [
//                 Icon(
//                   Icons.fiber_manual_record,
//                   size: 15,
//                   color: Colors.red,
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   'Close',
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ]),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(
//                   width: 1.5,
//                 ),
//                 // backgroundColor: Colors.black,
//               ),
//             ),
//             OutlinedButton(
//               onPressed: () {},
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.fiber_manual_record,
//                     size: 15,
//                     color: Colors.amber,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     'Busy',
//                     style: TextStyle(
//                       color: Colors.amber,
//                     ),
//                   ),
//                 ],
//               ),
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(
//                   width: 1.5,
//                 ),
//                 // backgroundColor: Colors.black,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
