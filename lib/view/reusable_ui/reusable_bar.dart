// import 'package:flutter/material.dart';

// class BarPainter extends CustomPainter {
//   final double width;
//   final int value;
//   final int index;

//   BarPainter({required this.width, required this.value, required this.index});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     if (this.value < 500 * .10) {
//       paint.color = Color(0xFFDEEDCF);
//     } else if (this.value < 500 * .20) {
//       paint.color = Color(0xFFBFE1B0);
//     } else if (this.value < 500 * .30) {
//       paint.color = Color(0xFF99D492);
//     } else if (this.value < 500 * .40) {
//       paint.color = Color(0xFF74C67A);
//     } else if (this.value < 500 * .50) {
//       paint.color = Color(0xFF56B870);
//     } else if (this.value < 500 * .60) {
//       paint.color = Color(0xFF39A96B);
//     } else if (this.value < 500 * .70) {
//       paint.color = Color(0xFF1D9A6C);
//     } else if (this.value < 500 * .80) {
//       paint.color = Color(0xFF188977);
//     } else if (this.value < 500 * .90) {
//       paint.color = Color(0xFF137177);
//     } else {
//       paint.color = Color(0xFF0E4D64);
//     }

//     paint.strokeWidth = width;
//     paint.strokeCap = StrokeCap.round;

//     canvas.drawLine(Offset(index * this.width, 0),
//         Offset(index * this.width, this.value.ceilToDouble()), paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({required this.width, required this.value, required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double intensity = value / 500; // Adjust intensity based on value

    // Define a linear gradient color
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 202, 26, 255), // Deep purple
        Color.fromARGB(255, 40, 235, 170), // Green
        Color.fromARGB(255, 48, 61, 243), // Green
        Color.fromARGB(255, 255, 74, 173)
      ],
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(
      index * width,
      0,
      width,
      value.ceilToDouble(),
    ));

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(index * width, 0),
      Offset(index * width, value.ceilToDouble()),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
