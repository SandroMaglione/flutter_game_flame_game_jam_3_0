import 'package:equatable/equatable.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

class GameState extends Equatable {
  final Map<int, PlayerStatus> npcMap;
  const GameState(this.npcMap);

  factory GameState.init() => const GameState(<int, PlayerStatus>{});

  int get flames => npcMap.values.whereType<Flame>().length;
  int get ices => npcMap.values.whereType<Ice>().length;

  int get totalNpc => npcMap.length;

  bool get isEnded => totalNpc > 0 && (flames == totalNpc || ices == totalNpc);

  @override
  List<Object?> get props => [npcMap];
}
