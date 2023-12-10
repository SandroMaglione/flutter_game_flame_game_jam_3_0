import 'package:equatable/equatable.dart';
import 'package:flutter_game_flame_game_jam_3_0/assets.dart';

sealed class PlayerStatus extends Equatable {
  const PlayerStatus();

  String get asset;

  @override
  List<Object?> get props => [asset];
}

final class Flame extends PlayerStatus {
  const Flame();

  @override
  String get asset => Assets.flamePng;

  @override
  String toString() => "TOO HOT";
}

final class Ice extends PlayerStatus {
  const Ice();

  @override
  String get asset => Assets.icePng;

  @override
  String toString() => "TOO COLD";
}
