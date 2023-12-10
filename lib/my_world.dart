import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/main.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

final Player _player = Player(50.0);
const double wallSize = 30;
const double origin = 500;
final Vector2 wallOrigin = Vector2(-origin, -origin);
const double wallLength = origin * 2;

final _npcs = List.generate(
  10,
  (i) => Npc(
    (Vector2.random().normalized() * (Random().nextBool() ? 1 : -1)),
  ),
);

class MyWorld extends World
    with
        HasGameRef<MyGame>,
        KeyboardHandler,
        HasCollisionDetection,
        RiverpodComponentMixin {
  MyWorld({super.children});

  @override
  void onMount() {
    addToGameWidgetBuild(() {
      ref.read(gameStateProvider.notifier).init(_npcs);
    });
    super.onMount();

    add(Wall(
      position: wallOrigin,
      size: Vector2(wallLength, wallSize),
    ));
    add(Wall(
      position: wallOrigin,
      size: Vector2(wallSize, wallLength),
    ));
    add(Wall(
      position: Vector2(wallOrigin.x, wallOrigin.y + wallLength),
      size: Vector2(wallLength, wallSize),
    ));
    add(Wall(
      position: Vector2(wallOrigin.x + wallLength, wallOrigin.y),
      size: Vector2(wallSize, wallLength + wallSize),
    ));

    addAll(_npcs);

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
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isKeyDown) {
      if (isLeft || isRight || isUp || isDown || isSpace) {
        List<Direction> turning = [];
        if (isLeft) {
          turning.add(const Left());
        }

        if (isRight) {
          turning.add(const Right());
        }

        if (isUp) {
          turning.add(const Up());
        }

        if (isDown) {
          turning.add(const Down());
        }

        _player.turn(turning);

        if (isSpace) {
          _player.changeStatus();
        }

        return true;
      }
    }

    return false;
  }
}
