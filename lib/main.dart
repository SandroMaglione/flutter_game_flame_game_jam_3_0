import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

final Player _player = Player();

class MyGame extends FlameGame with SingleGameInstance, KeyboardEvents {
  @override
  FutureOr<void> onLoad() {
    add(_player);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    final handled = _player.onKeyEvent(keysPressed);

    if (isKeyDown && handled) {
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
