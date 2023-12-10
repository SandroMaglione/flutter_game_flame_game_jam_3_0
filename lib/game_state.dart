import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef GameState = List<(int, PlayerStatus)>;

final gameStateProvider =
    NotifierProvider.autoDispose<GameStateNotifier, GameState>(
  GameStateNotifier.new,
);

class GameStateNotifier extends AutoDisposeNotifier<GameState> {
  @override
  GameState build() => [];

  void init(List<Npc> npcs) {
    GameState initList = [];
    for (var i = 0; i < npcs.length; i++) {
      final playerStatus = i % 2 == 0 ? const Flame() : const Ice();

      npcs[i].assignId(i, playerStatus);
      initList.add((i, playerStatus));
    }

    state = initList;
  }

  void update(int id, PlayerStatus playerStatus) {
    state = state
        .map(
          (e) => e.$1 != id ? e : (id, playerStatus),
        )
        .toList();
  }
}
