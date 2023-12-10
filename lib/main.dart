import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/assets.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';
import 'package:flutter_game_flame_game_jam_3_0/my_world.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
          bottom: 50,
          left: 150,
          right: 150,
          child: Center(
            child: BlocBuilder<GameStateCubit, GameState>(
              builder: (context, state) {
                final ended = state.isEnded;
                return ended != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Image.asset(
                              "images/${ended.asset}",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              context.read<GameStateCubit>().restart();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              child: Text(
                                "Click to restart",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 36,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Transform.scale(
                            scale: 1.5,
                            child: Image.asset(
                              "images/${ended.asset}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )
                    : StepProgressIndicator(
                        totalSteps: state.totalNpc > 0 ? state.totalNpc : 1,
                        padding: 0,
                        currentStep: state.flames,
                        selectedColor: Colors.orangeAccent,
                        unselectedColor: Colors.blueAccent,
                        size: 30,
                        roundedEdges: const Radius.circular(20),
                      );
              },
            ),
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
