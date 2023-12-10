import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state.dart';
import 'package:flutter_game_flame_game_jam_3_0/game_state_cubit.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

class Player extends SpriteComponent
    with
        HasGameRef,
        CollisionCallbacks,
        FlameBlocReader<GameStateCubit, GameState> {
  PlayerStatus playerStatus = const Flame();
  Vector2 _direction = Vector2.zero();
  double speed = 400.0;
  DateTime lastChange = DateTime.now();
  bool isChanging = false;

  Player(double size)
      : playerStatus = Random().nextBool() ? const Flame() : const Ice() {
    this.size = Vector2.all(size);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    sprite = Sprite(game.images.fromCache(playerStatus.asset));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (bloc.state.isEnded == null) {
      if (DateTime.now().difference(lastChange).inSeconds > 10) {
        bloc.endGame(this);
      } else {
        _direction *= 0.98;
        position.add(_direction * speed * dt);
      }
    }
  }

  void turn(List<Direction> direction) {
    if (!isChanging) {
      _direction = (_direction +
              direction.fold(
                Vector2.zero(),
                (value, dir) => value + dir.turn,
              ))
          .normalized();
    }
  }

  void changeStatus() {
    if (!isChanging) {
      isChanging = true;
      _direction = Vector2.zero();

      final effect = SequenceEffect([
        ScaleEffect.to(
          Vector2.all(0.3),
          EffectController(
            duration: 0.2,
          ),
        ),
        OpacityEffect.to(
          0,
          EffectController(
            duration: 0.1,
            onMax: () {
              playerStatus = switch (playerStatus) {
                Flame() => const Ice(),
                Ice() => const Flame(),
              };

              sprite = Sprite(game.images.fromCache(playerStatus.asset));
            },
          ),
        ),
        ScaleEffect.to(
          Vector2.all(1),
          EffectController(
            duration: 0.1,
            startDelay: 0.2,
          ),
        ),
        OpacityEffect.to(
          1,
          EffectController(
            duration: 0.1,
            startDelay: 0.2,
          ),
        ),
      ], onComplete: () {
        isChanging = false;
        bloc.changeStatusPlayer();
      });

      add(effect);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Wall) {
      _direction.invert();
    } else if (other is Npc && !isChanging) {
      lastChange = DateTime.now();
      other.changeStatus(playerStatus, true);
    }
  }
}
