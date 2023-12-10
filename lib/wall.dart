import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Wall extends RectangleComponent with CollisionCallbacks {
  Wall({
    required Vector2 position,
    required Vector2 size,
  }) {
    this.position = position;
    this.size = size;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.white;
    add(RectangleHitbox());
  }
}
