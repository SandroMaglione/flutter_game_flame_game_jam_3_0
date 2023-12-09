import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';
import 'package:flutter_game_flame_game_jam_3_0/wall.dart';

class Npc extends SpriteComponent with HasGameRef, CollisionCallbacks {
  PlayerStatus playerStatus = const Flame();
  Vector2 _direction = Vector2(0, 1);
  double speed = 200.0;

  Npc(Vector2 direction) {
    _direction = direction;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('logo.png');
    size = Vector2.all(30);
    position = (gameRef.size / 2) - Vector2.all(size.x / 2);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_direction * speed * dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);

    if (other is Wall) {
      _direction.invert();
    }
  }
}
