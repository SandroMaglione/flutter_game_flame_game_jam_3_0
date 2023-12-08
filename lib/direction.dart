import 'package:flame/game.dart';

sealed class Direction {
  const Direction();
  Vector2 get vector2;
}

class Idle extends Direction {
  const Idle();

  @override
  Vector2 get vector2 => Vector2(0, 0);
}

class Up extends Direction {
  const Up();

  @override
  Vector2 get vector2 => Vector2(0, -1);
}

class Down extends Direction {
  const Down();

  @override
  Vector2 get vector2 => Vector2(0, 1);
}

class Left extends Direction {
  const Left();

  @override
  Vector2 get vector2 => Vector2(-1, 0);
}

class Right extends Direction {
  const Right();

  @override
  Vector2 get vector2 => Vector2(1, 0);
}
