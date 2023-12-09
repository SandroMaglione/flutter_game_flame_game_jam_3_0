import 'package:flame/components.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

class Player extends SpriteComponent with HasGameRef {
  PlayerStatus _playerStatus = Flame();
  Vector2 _direction = Vector2(0, 1);
  double speed = 200.0;

  Player(double size) {
    this.size = Vector2.all(size);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('logo.png');
    position = (gameRef.size / 2) - Vector2.all(size.x / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_direction * speed * dt);
  }

  void turn(Direction direction) {
    _direction = (_direction + direction.turn).normalized();
  }
}
