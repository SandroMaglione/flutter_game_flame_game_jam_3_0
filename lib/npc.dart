import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_flame_game_jam_3_0/assets.dart';
import 'package:flutter_game_flame_game_jam_3_0/player.dart';
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
    sprite = Sprite(game.images.fromCache(Assets.flamePng));
    size = Vector2.all(30);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_direction * speed * dt);
  }

  void changeStatus(PlayerStatus to) {
    playerStatus = to;
    sprite = Sprite(game.images.fromCache(to.asset));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);

    if (other is Wall || other is Npc || other is Player) {
      _direction.invert();
    }
  }
}
