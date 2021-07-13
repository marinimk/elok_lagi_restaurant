import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitWave(
          type: SpinKitWaveType.center,
          color: Colors.pink,
          size: 50.0,
          itemCount: 10,
        ),
      ),
    );
  }
}
