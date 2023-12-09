import 'package:flame/game.dart';
import 'package:flutter_game_flame_game_jam_3_0/direction.dart';
import 'package:flutter_game_flame_game_jam_3_0/world_cell.dart';

abstract interface class WorldGrid {
  /// Size of the grid (square)
  int get size => 11;

  set cellSize(double size);
  double get cellSize;

  /// Generate new row/column in the specified [Direction] and remove
  /// row/column that goes outside limit
  void move(Direction direction);

  /// Render for each [WorldCell]
  void forEach(Function(Vector2 position, WorldCell cell) render);
}

class WorldGridImpl extends WorldGrid {
  late List<List<WorldCell>> grid;

  WorldGridImpl(this.cellSize) {
    grid = List.generate(
      size,
      (r) => List.generate(
        size,
        (c) => WorldCell.random,
      ),
    );
  }

  @override
  double cellSize;

  @override
  void move(Direction direction) {
    List<WorldCell> newCells = List.generate(
      size,
      (_) => WorldCell.random,
    );

    switch (direction) {
      case Up():
      // TODO: Handle this case.
      case Down():
      // TODO: Handle this case.
      case Left():
      // TODO: Handle this case.
      case Right():
      // TODO: Handle this case.
    }
  }

  @override
  void forEach(Function(Vector2 position, WorldCell cell) render) {
    for (var r = 0; r < size; r++) {
      for (var c = 0; c < size; c++) {
        render(
          Vector2(c * cellSize, r * cellSize),
          grid[r][c],
        );
      }
    }
  }
}