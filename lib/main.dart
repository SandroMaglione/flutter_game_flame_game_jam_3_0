import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_flame_game_jam_3_0/my_world.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame
    with SingleGameInstance, HasKeyboardHandlerComponents {
  MyGame() : myWorld = MyWorld() {
    cameraComponent = CameraComponent(world: myWorld);
  }

  late final CameraComponent cameraComponent;
  final MyWorld myWorld;

  @override
  FutureOr<void> onLoad() {
    addAll([cameraComponent, myWorld]);
    debugMode = true;
  }
}
