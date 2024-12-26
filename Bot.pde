class BotMove {
  Direction[] moves;
  float score;
  
  BotMove(Direction[] moves, Player player) {
    int cornerValue = player.grid[0][0] == null ? 0 : player.grid[0][0].value;
    float multiplier = player.score == 0 ? 0.0 : (float) cornerValue / player.score;
    this.moves = moves;
    this.score = player.numMergableTiles == 0
    ? 0.0 
    : (float) player.score / player.numMergableTiles * player.numFreeTiles * multiplier;
  }
}

class Bot implements BotOrPlayer {
  Player player;
  int movesPerStep = 8;
  int frame = 0;
  Direction[] nextMoves = new Direction[movesPerStep];
  
  Bot() {
    player = new Player();
    player.draw();
  }
  
  BotMove calculateBestMove(Player player, int moveIdx, Direction[] moves) {
    if (moveIdx == movesPerStep || player.gameOver) {
      // print("Potential moves ");
      // for (Direction direction : moves) {
      //   if (direction == null) continue;
      //   print(direction.name, "-> ");
      // }
      BotMove botMove = new BotMove(moves, player);
      // println("result in score", botMove.score, player.gameOver ? "(game over)" : "");
      return botMove;
    }
    BotMove[] botMoves = new BotMove[DIRECTIONS.length];
    int bestMove = -1;
    for (int directionIdx = 0; directionIdx < DIRECTIONS.length; directionIdx++) {
      Direction[] newMoves = moves.clone();
      Direction direction = DIRECTIONS[directionIdx];
      newMoves[moveIdx] = direction;
      Player clone = player.clone();
      clone.move(direction);
      BotMove botMove = calculateBestMove(clone, moveIdx + 1, newMoves);
      botMoves[directionIdx] = botMove;
      if (bestMove == -1 || botMove.score > botMoves[bestMove].score) {
        bestMove = directionIdx;
      }
    }
    if (moveIdx == 0 && botMoves[bestMove].score == 0) {
      println("All possible moves result in game over.");
    }
    return botMoves[bestMove];
  }
  
  void makeMove() {
    boolean moved = false;
    for (int i = 0; i < nextMoves.length; i++) {
      Direction direction = nextMoves[i];
      if (direction == null) continue;
      player.move(direction);
      moved = true;
      nextMoves[i] = null;
      if (player.gameOver) {
        println("Final score:", player.score);
      }
      break;
    }
    if (!moved) {
      nextMoves = calculateBestMove(player.clone(), 0, new Direction[movesPerStep]).moves;
      makeMove();
      // delay(200);
    }
  }
  
  void draw() {
    player.draw();
    frame++;
    if (player.gameOver) return; 
    // if (frame % 20 == 0)
    makeMove();
  }
  
  void move(Direction _direction) {
    // no-op method
  }
  
  void reset() {
    player.reset();
  }
}