import 'package:flame/components.dart';

class Player extends SpriteComponent with HasGameRef {
  Player() : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('logo.png');
    position = gameRef.size / 2;
  }
}
