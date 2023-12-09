import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/main.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

final Player _player = Player(50.0);

class MyWorld extends World with HasGameRef<MyGame>, KeyboardHandler {
  MyWorld({super.children});

  @override
  FutureOr<void> onLoad() {
    addAll(
      List.generate(
        10,
        (i) => Npc(
          (Vector2.random().normalized() * (Random().nextBool() ? 1 : -1)),
        ),
      ),
    );

    add(
      Wall(
        position: Vector2(-100.0, 100.0),
        size: Vector2(1800, 30),
      ),
    );
    add(
      Wall(
        position: Vector2(-100.0, 100.0),
        size: Vector2(30, 1800),
      ),
    );
    add(
      Wall(
        position: Vector2(100.0, 100.0),
        size: Vector2(1800, 30),
      ),
    );
    add(
      Wall(
        position: Vector2(-100.0, -100.0),
        size: Vector2(1800, 30),
      ),
    );

    add(_player);
    gameRef.cameraComponent.follow(_player);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isLeft = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRight = keysPressed.contains(LogicalKeyboardKey.keyD);
    final isUp = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isDown = keysPressed.contains(LogicalKeyboardKey.keyS);

    if (isKeyDown) {
      if (isLeft || isRight || isUp || isDown) {
        if (isLeft) {
          _player.turn(const Left());
        }

        if (isRight) {
          _player.turn(const Right());
        }

        if (isUp) {
          _player.turn(const Up());
        }

        if (isDown) {
          _player.turn(const Down());
        }

        return true;
      }
    }

    return false;
  }
}