import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

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
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    ),
  );
}

ButtonStyle circularElevatedButton() {
  return ElevatedButton.styleFrom(
    shape: CircleBorder(),
    padding: EdgeInsets.all(10),
  );
}

Row buttonTextRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon),
      SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 16)),
    ],
  );
}

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
