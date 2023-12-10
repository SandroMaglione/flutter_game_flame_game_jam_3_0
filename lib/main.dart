import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/assets.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';
import 'package:flutter_game_flame_game_jam_3_0/my_world.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame Game Jam 3.0',
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => GameStateCubit(),
            ),
          ],
          child: const GameView(),
        ),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GameWidget(
            game: MyGame(
              context.read<GameStateCubit>(),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: Builder(builder: (context) {
              final gameStateCubit = context.watch<GameStateCubit>();
              return Text(
                "${gameStateCubit.flames}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class MyGame extends FlameGame
    with SingleGameInstance, HasKeyboardHandlerComponents {
  MyGame(this.gameStateCubit) : myWorld = MyWorld() {
    cameraComponent = CameraComponent(world: myWorld);
  }

  late final CameraComponent cameraComponent;
  final MyWorld myWorld;
  final GameStateCubit gameStateCubit;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    debugMode = true;

    await images.loadAll([Assets.flamePng, Assets.icePng]);
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStateCubit, GameState>.value(
            value: gameStateCubit,
          ),
        ],
        children: [cameraComponent, myWorld],
      ),
    );
  }
}
