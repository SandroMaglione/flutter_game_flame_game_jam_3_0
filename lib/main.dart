import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_flame_game_jam_3_0/assets.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/my_world.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Game Jam 3.0',
      home: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: RiverpodAwareGameWidget(
              game: MyGame(),
              key: gameWidgetKey,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final gameState = ref.watch(gameStateProvider);
                  return Text("Here: ${gameState.length}");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyGame extends FlameGame
    with SingleGameInstance, HasKeyboardHandlerComponents, RiverpodGameMixin {
  MyGame() : myWorld = MyWorld() {
    cameraComponent = CameraComponent(world: myWorld);
  }

  late final CameraComponent cameraComponent;
  final MyWorld myWorld;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    await images.loadAll([Assets.flamePng, Assets.icePng]);
    addAll([cameraComponent, myWorld]);
    debugMode = true;
  }
}
