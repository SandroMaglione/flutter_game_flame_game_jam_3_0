import 'package:flame/components.dart';

const _turn = 1.0;

sealed class Direction {
  const Direction();

  Vector2 get turn;
}

class Up extends Direction {
  const Up();

  @override
  Vector2 get turn => Vector2(0, -_turn);
}

class Down extends Direction {
  const Down();

  @override
  Vector2 get turn => Vector2(0, _turn);
}

class Left extends Direction {
  const Left();

  @override
  Vector2 get turn => Vector2(-_turn, 0);
}

class Right extends Direction {
  const Right();

  @override
  Vector2 get turn => Vector2(_turn, 0);
}
