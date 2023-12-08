import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';

class Player extends SpriteComponent with HasGameRef {
  Direction direction = const Idle();

  final double speed;
  Player({this.speed = 10.0}) : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('logo.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _move(dt);
  }

  void _move(double delta) {
    if (direction is! Idle) {
      position.add(direction.vector2 * speed);
    }
  }

  bool onKeyEvent(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      direction = const Up();
      return true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      direction = const Down();
      return true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      direction = const Left();
      return true;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      direction = const Right();
      return true;
    }

    direction = const Idle();
    return false;
  }
}
