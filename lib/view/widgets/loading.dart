import 'package:elok_lagi_restaurant/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white.withOpacity(0),
        child: Center(child: SpinKitHourGlass(color: colorsConst[500])));
  }
}
