// import 'package:flutter/material.dart';

// class SignUp extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             buildTextField(Icons.house_siding, "Restaurant Name", false, false),
//             buildTextField(Icons.phone_android, "Phone Number", false, false),
//             buildTextField(Icons.email, "Email", false, true),
//             buildTextField(Icons.lock, "Password", true, false),
//             buildTextField(Icons.lock, "Confirm Password", true, false),
//             Container(
//               width: 200,
//               margin: EdgeInsets.only(top: 20),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   text: "By pressing 'Submit' you agree to our ",
//                   style: TextStyle(
//                     color: Color(0XFF9BB3C0),
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "terms & conditions",
//                       style: TextStyle(color: Colors.orange),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Text(error),
//             ),
//           ],
//         ),
//       ),
//     );
  
//   }
// }