import 'package:flame/components.dart';
import 'package:flutter_game_flame_game_jam_3_0/player_status.dart';

class Player extends SpriteComponent with HasGameRef {
  PlayerStatus _playerStatus = Flame();

  Player(double size) {
    this.size = Vector2.all(size);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('logo.png');
    position = gameRef.size / 2;
  }
}
