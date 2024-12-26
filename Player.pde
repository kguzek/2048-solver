class Player {
  int score = 0;
  int moves = 0;
  boolean gameOver = false;
  int textCycle = 0;
  Tile[][] grid = new Tile[Settings.columns][Settings.rows];
  
  Player() {
    for (int i = 0; i < Settings.startingTiles; i++) {
      generateRandomTile();
    }
  }
  
  void generateRandomTile() {
    int x = -1;
    int y = -1;
    while (x == -1 || y == -1 || grid[y][x] != null) {
      x = floor(random(Settings.columns));
      y = floor(random(Settings.rows));
    }
    Tile tile = new Tile();
    grid[y][x] = tile;
    score = max(score, tile.value);
  }
  
  void draw() {
    for (int y = 0; y < grid.length; y++) {
      Tile[] row = grid[y];
      for (int x = 0; x < row.length; x++) {
        Tile tile = row[x];
        if (tile == null) continue;
        tile.draw(x, y);
      }
    }
    textAlign(RIGHT, TOP);
    fill(64, 64, 64);
    text("Score: " + score, Settings.screenWidth, Settings.padding);
    text("Moves: " + moves, Settings.screenWidth, Settings.padding * 6);
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
    boolean gridIsFull = true;
    for (Tile[] row : grid) {
      for (Tile tile : row) {
        if (tile == null) {
          gridIsFull = false;
          continue;
        }
        score = max(tile.value, score);
      }
    }
    if (gridIsFull || score >= 2048) {
      gameOver = true;
    }
  }
        
  
  void move(int dx, int dy) {
    for (int i = 0; i < Settings.rows; i++) {
      for (int j = 0; j < Settings.columns; j++) {
        // Check if moving toward right or bottom edge
        int y = i;
        int x = j;
        if (dx + dy == 1) {
          if (dy == 0) {
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
        while (isValidTile(nextX + dx, nextY + dy)) {
          adjacentTile = grid[nextY + dy][nextX + dx];
          if (adjacentTile != null) break;
          nextX += dx;
          nextY += dy;
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
    if (!gameOver) {
      generateRandomTile();
    }
  }
}
