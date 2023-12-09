import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
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

    const direction = Up();

    _worldGrid.startMove();
    gridCells.forEach((cell) {
      cell.add(
        MoveEffect.by(
          Vector2(0, _worldGrid.cellSize),
          EffectController(
            duration: 2,
            onMax: () {
              print("Done $cell");
            },
          ),
        ),
      );
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_worldGrid.isMoving) {
      // Trigger next movement
    }
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isKeyDown && isSpace) {
      // Activate current cell
      print(_worldGrid.current);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
