import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

final Player _player = Player();

class MyGame extends FlameGame with SingleGameInstance {
  @override
  Color backgroundColor() => Colors.purple;

  @override
  FutureOr<void> onLoad() {
    add(_player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
