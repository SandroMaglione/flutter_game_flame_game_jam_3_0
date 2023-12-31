import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

class Npc extends SpriteComponent
    with
        HasGameRef,
        CollisionCallbacks,
        FlameBlocReader<GameStateCubit, GameState> {
  Vector2 _direction = Vector2(0, 1);
  double speed = 200.0;
  double stength;

  bool isChanging = false;
  PlayerStatus playerStatus;
  final int id;

  Npc(Vector2 position, {required this.id, required this.playerStatus})
      : stength = Random().nextDouble() {
    this.position = position;
    _direction = Vector2.random() * (Random().nextBool() ? 1 : -1);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    sprite = Sprite(game.images.fromCache(playerStatus.asset));
    size = Vector2.all(35);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isChanging) {
      position.add(_direction * speed * dt);
    }
  }

  void changeStatus(PlayerStatus to, bool fromPlayer) {
    if (!isChanging && playerStatus != to) {
      isChanging = true;

      final effect = SequenceEffect([
        ScaleEffect.to(
          Vector2.all(0.4),
          EffectController(
            duration: 0.2,
          ),
        ),
        OpacityEffect.to(
          0.4,
          EffectController(
            duration: 0.4,
            onMax: () {
              playerStatus = to;
              sprite = Sprite(game.images.fromCache(to.asset));
            },
          ),
        ),
        ScaleEffect.to(
          Vector2.all(1),
          EffectController(
            duration: 0.2,
            startDelay: 0.4,
          ),
        ),
        OpacityEffect.to(
          1,
          EffectController(
            duration: 0.1,
            startDelay: 0.45,
          ),
        ),
      ], onComplete: () {
        isChanging = false;
        bloc.changeStatus(this, fromPlayer);
      });

      add(effect);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (bloc.state.isEnded == null) {
      if (other is Wall) {
        _direction.invert();
      } else if (other is Npc &&
          !other.isChanging &&
          other.playerStatus != playerStatus) {
        if (stength > other.stength) {
          other.changeStatus(playerStatus, false);
        } else {
          changeStatus(other.playerStatus, false);
        }
      }
    }
  }
}
