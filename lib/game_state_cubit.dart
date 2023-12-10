import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

typedef GameState = Map<int, Npc>;

class GameStateCubit extends Cubit<GameState> {
  GameStateCubit() : super(<int, Npc>{});

  List<Npc> init(int n) {
    GameState gameState = {};
    List<Npc> npcs = [];
    for (var i = 0; i < n; i++) {
      final npc = Npc(
        Vector2.random(),
        id: i,
        playerStatus: i % 2 == 0 ? const Flame() : const Ice(),
      );

      npcs.add(npc);
      gameState.putIfAbsent(i, () => npc);
    }

    emit(gameState);
    return npcs;
  }
}
