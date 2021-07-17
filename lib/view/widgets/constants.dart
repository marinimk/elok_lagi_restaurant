import 'package:flutter/material.dart';

const colorsConst = {
  50: const Color(0xffF3F7F2), //10%
  100: const Color(0xffDAE8D9), //20%
  200: const Color(0xffC1D8C0), //30%
  300: const Color(0xffA8C9A6), //40%
  400: const Color(0xff8FB98D), //50%
  500: const Color(0xff76a973), //60%
  600: const Color(0xff60985D), //70%
  700: const Color(0xff507E4E), //80%
  800: const Color(0xff3F653E), //90%
  900: const Color(0xff2F4C2F), //100%
};

InputDecoration textInputDecoration(IconData icon, String title) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: Color(0xFFB6C7D1),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA7BCC7),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(35.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFFA7BCC7),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(35.0),
      ),
    ),
    contentPadding: EdgeInsets.all(10),
    hintText: title,
    hintStyle: TextStyle(
      fontSize: 14,
      color: Color(0XFFA7BCC7),
    ),
  );
}

ButtonStyle elevatedButtonStyle() {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(Size(100, 40)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),

        // side: BorderSide(
        //     // width: 2,
        //     // color: Colors.red,
        //     ),
      ),
    ),
  );
}

Row buttonTextRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon),
      SizedBox(width: 5),
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}
