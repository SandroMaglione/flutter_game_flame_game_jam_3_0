import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/npc.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  PlayerStatus playerStatus = const Flame();
  Vector2 _direction = Vector2.zero();
  double speed = 400.0;

  Player(double size)
      : playerStatus = Random().nextBool() ? const Flame() : const Ice() {
    this.size = Vector2.all(size);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = Sprite(game.images.fromCache(playerStatus.asset));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    _direction *= 0.98;
    position.add(_direction * speed * dt);
  }

  void turn(List<Direction> direction) {
    _direction = (_direction +
            direction.fold(
              Vector2.zero(),
              (value, dir) => value + dir.turn,
            ))
        .normalized();
  }

  void changeStatus() {
    playerStatus = switch (playerStatus) {
      Flame() => const Ice(),
      Ice() => const Flame(),
    };

    sprite = Sprite(game.images.fromCache(playerStatus.asset));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);

    if (other is Wall) {
      _direction.invert();
    } else if (other is Npc) {
      // _direction.invert();
      other.changeStatus(playerStatus);
    }
  }
}
