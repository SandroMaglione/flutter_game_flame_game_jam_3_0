import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

typedef GameState = Map<int, PlayerStatus>;

class GameStateCubit extends Cubit<GameState> {
  GameStateCubit() : super(<int, PlayerStatus>{});

  List<Npc> init(int n) {
    GameState gameState = {};
    List<Npc> npcs = [];
    for (var i = 0; i < n; i++) {
      final playerStatus = i % 2 == 0 ? const Flame() : const Ice();
      final npc = Npc(
        Vector2.random(),
        id: i,
        playerStatus: playerStatus,
      );

      npcs.add(npc);
      gameState.putIfAbsent(i, () => playerStatus);
    }

    emit(gameState);
    return npcs;
  }

  void changeStatus(Npc npc) {
    final newState = <int, PlayerStatus>{...state};
    newState.update(npc.id, (value) => npc.playerStatus);
    emit(newState);
  }

  int get flames => state.values.whereType<Flame>().length;
  int get ices => state.values.whereType<Ice>().length;

  int get totalNpc => state.length;
}
