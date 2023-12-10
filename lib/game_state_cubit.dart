import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

class GameStateCubit extends Cubit<GameState> {
  GameStateCubit() : super(GameState.init());

  List<Npc> init(int n) {
    Map<int, PlayerStatus> gameState = {};
    List<Npc> npcs = [];
    for (var i = 0; i < n; i++) {
      final playerStatus = i % 2 == 0 ? const Flame() : const Ice();
      final npc = Npc(
        Vector2(Random().nextDouble() * (1000 * 0.8) - (500 * 0.8),
            Random().nextDouble() * (1000 * 0.8) - (500 * 0.8)),
        id: i,
        playerStatus: playerStatus,
      );

      npcs.add(npc);
      gameState.putIfAbsent(i, () => playerStatus);
    }

    emit(GameState(gameState, 0));
    return npcs;
  }

  void changeStatus(Npc npc, bool fromPlayer) {
    if (state.isEnded == null) {
      emit(state.updateNpc(npc, fromPlayer));
    }
  }

  void changeStatusPlayer() {
    if (state.isEnded == null) {
      emit(state.losePoints());
    }
  }
}
