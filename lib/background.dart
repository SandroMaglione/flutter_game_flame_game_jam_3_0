import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';

class Background extends RectangleComponent
    with FlameBlocListenable<GameStateCubit, GameState> {
  Background() {
    position = Vector2(-1500, -1500);
    size = Vector2(3000, 3000);
    paint.color = Colors.transparent;
  }

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    paint.color = (Color.lerp(
              const Color.fromRGBO(32, 42, 68, 1),
              const Color.fromRGBO(219, 34, 42, 1),
              state.flames / state.totalNpc,
            ) ??
            paint.color)
        .withOpacity(0.5);
  }
}
