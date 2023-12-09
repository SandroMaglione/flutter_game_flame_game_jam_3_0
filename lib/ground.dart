import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

const _size = 20;
const origin = 500;

class Ground extends CustomPainterComponent {
  @override
  FutureOr<void> onLoad() {
    painter = Painter();
    position = Vector2(-origin.toDouble(), -origin.toDouble());
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (var r = 0; r < (origin * 2); r += _size) {
      for (var c = 0; c < (origin * 2); c += _size) {
        canvas.drawRect(
          Rect.fromLTWH(
            r.toDouble(),
            c.toDouble(),
            _size.toDouble(),
            _size.toDouble(),
          ),
          Paint()..color = Colors.amber,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
