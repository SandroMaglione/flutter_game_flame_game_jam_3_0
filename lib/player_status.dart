import 'package:flutter_game_flame_game_jam_3_0/assets.dart';

sealed class PlayerStatus {
  const PlayerStatus();

  String get asset;
}

final class Flame extends PlayerStatus {
  const Flame();

  @override
  String get asset => Assets.flamePng;
}

final class Ice extends PlayerStatus {
  const Ice();

  @override
  String get asset => Assets.icePng;
}
