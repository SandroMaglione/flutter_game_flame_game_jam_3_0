import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

class GameState extends Equatable {
  final Map<int, PlayerStatus> npcMap;
  final double points;
  const GameState(this.npcMap, this.points);

  factory GameState.init() => const GameState(<int, PlayerStatus>{}, 0);

  int get flames => npcMap.values.whereType<Flame>().length;
  int get ices => npcMap.values.whereType<Ice>().length;

  int get totalNpc => npcMap.length;

  PlayerStatus? get isEnded => totalNpc > 0
      ? (flames == totalNpc
          ? const Flame()
          : ices == totalNpc
              ? const Ice()
              : null)
      : null;

  GameState addPoints(double points) => GameState(
        npcMap,
        this.points + points,
      );

  GameState losePoints() => GameState(
        npcMap,
        max(0, points - 20),
      );

  GameState updateNpc(Npc npc, bool fromPlayer) {
    final newState = <int, PlayerStatus>{...npcMap};
    newState.update(npc.id, (value) => npc.playerStatus);
    return GameState(newState, points + (fromPlayer ? 10 : 0));
  }

  @override
  List<Object?> get props => [npcMap, points];
}
