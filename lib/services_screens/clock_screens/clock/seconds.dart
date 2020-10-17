import 'dart:math';

import 'package:flutter/material.dart';

class Seconds extends CustomPainter {
  final Paint secondHandPaint;
  final int seconds;

  Seconds({this.seconds}) : secondHandPaint = new Paint() {
    secondHandPaint.color = Colors.red;
    secondHandPaint.style = PaintingStyle.stroke;
    secondHandPaint.strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * this.seconds / 60);

    Path path = new Path();
    path.moveTo(0.0, -radius);
    path.lineTo(0.0, radius/4);
    canvas.drawPath(path, secondHandPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(Seconds oldDelegate) {
    return this.seconds != oldDelegate.seconds;
  }

}