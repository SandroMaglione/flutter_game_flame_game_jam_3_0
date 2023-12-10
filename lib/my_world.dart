import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/background.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';
import 'package:flutter_game_flame_game_jam_3_0/main.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

final Player _player = Player(60.0);
const double wallSize = 30;
const double origin = 500;
final Vector2 wallOrigin = Vector2(-origin, -origin);
const double wallLength = origin * 2;

class MyWorld extends World
    with
        HasGameRef<MyGame>,
        KeyboardHandler,
        HasCollisionDetection,
        FlameBlocReader<GameStateCubit, GameState> {
  MyWorld({super.children});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(Background());

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

    final npcs = bloc.init(10);
    addAll(npcs);

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

    if (isKeyDown && bloc.state.isEnded == null) {
      if (isSpace) {
        _player.changeStatus();
        return true;
      } else if (isLeft || isRight || isUp || isDown) {
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

        return true;
      }
    }

    return false;
  }
}
