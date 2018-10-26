import 'package:flutter/material.dart';
import 'dart:math';

class TickCanvas extends CustomPainter {
  Paint _paint;
  double anim1 = 0.0;
  double anim2 = 0.0;
  double anim3 = 0.0;
  double width;
  double height;
  double fractionLeft;
  double animCircle = 0.0;
  bool isTransform = true;


  static final TickCanvas _tickCanvas = new TickCanvas._internal();

  factory TickCanvas() {
    return _tickCanvas;
  }

  TickCanvas._internal();

  @override
  void paint(Canvas canvas, Size size) {
    _paint = new Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2.0;

    double startX1 = width / 2;
    double startY1 = height / 2;
    double animX = width / 2;
    double animY = height / 2;

    double startX2 = width / 2;
    double startY2 = height / 2;

    if (fractionLeft >= 1.0 && anim1 < 7.0) {
      anim1 += 1.0;
    }

    if (anim1 == 7.0) {
      startX2 = width / 2 - 1;
      if (anim2 < 20.0) {
        anim2 += 1.0;
      }

      if (anim3 < 20.0) {
        anim3 += 1.0;
      }
    }

    if(isTransform){
      canvas.drawLine(
          Offset(startX1, startY1), Offset(animX - anim1, animY - anim1), _paint);
      canvas.drawLine(
          Offset(startX2, startY2), Offset(animX + anim2, animY - anim3), _paint);
    }



  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
