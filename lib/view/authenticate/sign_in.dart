// import 'package:flutter/material.dart';

// class SignIn extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             buildTextField(Icons.email, "Email", false, true),
//             buildTextField(Icons.lock, "Password", true, false),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isRememberMe,
//                       activeColor: Color(0XFF9BB3C0),
//                       onChanged: (value) {
//                         setState(() => isRememberMe = !isRememberMe);
//                       },
//                     ),
//                     Text(
//                       "Remember me",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color(0XFFA7BCC7),
//                       ),
//                     )
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0XFFA7BCC7),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }