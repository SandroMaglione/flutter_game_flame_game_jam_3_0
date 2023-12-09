import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  FutureOr<void> onLoad() {
    _worldGrid.forEach(
      (position, cell) => {
        add(
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

    add(_player);
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
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
