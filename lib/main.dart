import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';
import 'package:flutter_game_flame_game_jam_3_0/world_grid.dart';

const _cellSize = 50.0;

final Player _player = Player(_cellSize);
final WorldGrid _worldGrid = WorldGridImpl(_cellSize);

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame
    with SingleGameInstance, KeyboardEvents, HasGameRef {
  List<RectangleComponent> gridCells = List.empty(growable: true);

  @override
  FutureOr<void> onLoad() {
    _worldGrid.forEach(
      (position, cell) => {
        gridCells.add(
          RectangleComponent.square(
            size: _worldGrid.cellSize,
            position: position +
                (gameRef.size / 2) -
                Vector2.all(_worldGrid.size * _worldGrid.cellSize / 2),
            paint: Paint()..color = cell.color,
          ),
        )
      },
    );

    addAll(gridCells);
    add(_player);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    final isLeft = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRight = keysPressed.contains(LogicalKeyboardKey.keyD);
    final isUp = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isDown = keysPressed.contains(LogicalKeyboardKey.keyS);

    if (isKeyDown) {
      if (isLeft) {
        print("Left");
        _player.turn(const Left());
      }

      if (isRight) {
        print("Right");
        _player.turn(const Right());
      }

      if (isUp) {
        print("Up");
        _player.turn(const Up());
      }

      if (isDown) {
        print("Down");
        _player.turn(const Down());
      }

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
