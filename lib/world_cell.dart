import 'dart:math';

import 'package:flutter/material.dart';

sealed class WorldCell {
  const WorldCell();

  /// Rendering color of the cell
  ///
  /// (TODO: Convert to sprite)
  Color get color;

  static WorldCell get random => switch (Random().nextInt(10)) {
        0 => const ChangeDirectionCell(),
        1 => const SwitchStatusCell(),
        2 => const FlameCell(),
        3 => const IceCell(),
        _ => const EmptyCell(),
      };
}

class EmptyCell extends WorldCell {
  const EmptyCell();

  @override
  Color get color => Colors.black38;
}

class ChangeDirectionCell extends WorldCell {
  const ChangeDirectionCell();

  @override
  Color get color => Colors.pink;
}

class SwitchStatusCell extends WorldCell {
  const SwitchStatusCell();

  @override
  Color get color => Colors.grey;
}

class FlameCell extends WorldCell {
  const FlameCell();

  @override
  Color get color => Colors.orange;
}

class IceCell extends WorldCell {
  const IceCell();

  @override
  Color get color => Colors.blue;
}
