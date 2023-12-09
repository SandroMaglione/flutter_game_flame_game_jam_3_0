# [`Flame Game Jam 3.0`](https://itch.io/jam/flame-jam-3)

## Brainstorming
- Hot: **flame**
- Cold: **ice**
- Limitation: **One button**

Having only one button means that the game must move by itself, and the button allows your player to change itself to react to the world.

> Core idea: **Hot and cold as opposites**, but both necessary in balance

### Idea
Player is a flame/ice constantly moving in a grid. When you click you "activate" the effect of the cell your are on:
- Cells in the grid allow you to change direction
- Cells allow you to switch between flame/ice

You must keep the balance between hot and cold. While you are a flame you keep getting more hot. While you are ice you keep getting more cold.

Some cells also have a flame/ice on them:
- Flame cells add more "hot"
- Ice cells add more "cold"

As you progress the movement gets faster. Resist as much as you can.

### Mechanics
- Grid auto-generation
  - "Empty" cells (no effect)
  - Change direction cells
  - Flame cells
  - Ice cells
  - Switch flame/ice cells
- Balancer hot/cold
  - Keep track of current status
- Movement cell by cell
  - Keep track of current direction (4 directions)
  - Increase speed as time progress
- Score (time)

### Attention
- Allow player to see enough cells to form a strategy to progress
- Keep right balance in cells (especially switch between flame/ice)