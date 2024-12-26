class Player implements BotOrPlayer{
  int score;
  int moves;
  boolean gameOver = true;
  boolean gridIsFull;
  int numMergableTiles;
  int textCycle;
  Tile[][] grid;
  
  Player() {
    reset();
  }
  
  Player clone() {
    Player cloned = new Player();
    cloned.score = score;
    cloned.moves = moves;
    cloned.gameOver = gameOver;
    cloned.gridIsFull = gridIsFull;
    cloned.numMergableTiles = numMergableTiles;
    cloned.textCycle = textCycle;
    cloned.grid = grid;
    return cloned;
  }
  
  
  void generateRandomTile() {
    if (gridIsFull) return;
    int x = -1;
    int y = -1;
    while(x == -1 || y == -1 || grid[y][x] != null) {
      x = floor(random(Settings.columns));
      y = floor(random(Settings.rows));
    }
    Tile tile = new Tile();
    grid[y][x] = tile;
    score = max(score, tile.value);
  }
  
  void reset() {
    if (!gameOver) return;
    score = 0;
    moves = 0;
    gameOver = false;
    gridIsFull = false;
    numMergableTiles = 0;
    textCycle = 0;
    grid = new Tile[Settings.columns][Settings.rows];
    for (int i = 0; i < Settings.startingTiles; i++) {
      generateRandomTile();
    }
  }
  
  void draw() {
    fill(192, 192, 192);
    rect(0, 0, Settings.screenWidth, Settings.ribbonHeight);
    for (int y = 0; y < grid.length; y++) {
      Tile[] row = grid[y];
      for (int x = 0; x < row.length; x++) {
        Tile tile = row[x];
        if (tile == null) continue;
        tile.draw(x, y);
      }
    }
    fill(64, 64, 64);
    textAlign(LEFT, TOP);
    text("Score: " + score, Settings.padding, Settings.padding);
    textAlign(CENTER, TOP);
    text("Available moves: " + numMergableTiles, Settings.screenWidth / 2, Settings.padding);
    textAlign(RIGHT, TOP);
    text("Moves: " + moves, Settings.screenWidth - Settings.padding, Settings.padding);
    if (!gameOver) return;
    textCycle = (textCycle + 1) % Settings.textBlinkDuration;
    if (textCycle >= Settings.textBlinkDuration / 2) return;
    textAlign(CENTER, CENTER);
    textSize(100);
    boolean won = score >= 2048;
    if (won) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    text(won ? "YOU WIN!" : "YOU LOSE!", Settings.screenWidth / 2, Settings.screenHeight / 2);
  }
  
  boolean isValidTile(int x, int y) {
    return x >= 0 && y >= 0 && x < Settings.columns && y < Settings.rows;
  }
  
  void checkGrid() {
    gridIsFull = true;
    numMergableTiles = 0;
    for (int y = 0; y < Settings.rows; y++) {
      for (int x = 0; x < Settings.columns; x++) {
        Tile tile = grid[y][x];
        if (tile == null) {
          gridIsFull = false;
          continue;
        }
        score = max(tile.value, score);
        for (int dy = -1; dy <= 1; dy++) {
          for (int dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0 || dx * dy != 0) continue;
            if (!isValidTile(x + dx, y + dy)) continue;
            Tile adjacentTile = grid[y + dy][x + dx];
            if (adjacentTile == null || adjacentTile.value == tile.value) {
              numMergableTiles++;
              continue;
            }
          }
        }
      }
    }
    numMergableTiles /= 2;
    if (numMergableTiles == 0 || score >= 2048) {
      gameOver = true;
    }
  }
  
  
  void move(Direction direction) {
    if (gameOver) return;
    for (int i = 0; i < Settings.rows; i++) {
      for (int j = 0; j < Settings.columns; j++) {
        //Check if moving toward right or bottom edge
        int y = i;
        int x = j;
        if (direction.dx + direction.dy == 1) {
          if (direction.dy == 0) {
            x = Settings.columns - 1 - x;
          } else {
            y = Settings.rows - 1 - y;
          }
        }
        Tile tile = grid[y][x];
        if (tile == null) continue;
        int nextX = x;
        int nextY = y;
        Tile newTile = null;
        Tile adjacentTile = null;
        while(isValidTile(nextX + direction.dx, nextY + direction.dy)) {
          adjacentTile = grid[nextY + direction.dy][nextX + direction.dx];
          if (adjacentTile != null) break;
          nextX += direction.dx;
          nextY += direction.dy;
        }
        if (adjacentTile != null && adjacentTile.value == tile.value) {
          adjacentTile.value = 2 * tile.value;
          grid[y][x] = null;
          continue;
        }
        newTile = grid[nextY][nextX];
        if (newTile == null) {
          grid[nextY][nextX] = tile;
          grid[y][x] = null;
          continue;
        };
      }
    }
    moves += 1;
    checkGrid();
    generateRandomTile();
  }
}
