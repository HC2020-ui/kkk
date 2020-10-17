import 'dart:math';

import 'package:flutter/material.dart';

class Minutes extends CustomPainter {
  final Paint minuteHandPaint;

  final int minutes;
  final int seconds;

  Minutes({this.minutes, this.seconds}) : minuteHandPaint = new Paint() {
    minuteHandPaint.color = Colors.white;
    minuteHandPaint.style = PaintingStyle.stroke;
    minuteHandPaint.strokeWidth = 4.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));

    Path path = new Path();
    path.moveTo(0.0, -radius + radius / 10);
    path.lineTo(0.0, 0.0);
    canvas.drawPath(path, minuteHandPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(Minutes oldDelegate) {
    return this.seconds != oldDelegate.seconds;
  }
}
