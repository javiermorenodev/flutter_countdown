import 'package:flutter/material.dart';
import 'dart:math' as math;

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgrounColor;

  TimerPainter({required this.animation, required this.backgrounColor});

  Path getWheelPath(double wheelSize, double fromRadius, double toRadius) {
    return Path()
      ..moveTo(wheelSize, wheelSize)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(wheelSize, wheelSize), radius: wheelSize),
          fromRadius,
          -toRadius,
          false)
      ..close();
  }

  Paint getColorPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = size.width / 2;
    double radius = (2 * math.pi) / 4;
    canvas.drawPath(
        getWheelPath(wheelSize, -radius, radius * (4 * animation.value)),
        getColorPaint(backgrounColor));
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return oldDelegate != this;
  }
}
