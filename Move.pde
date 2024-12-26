class Move {
  int dx;
  int dy;
  
  Move(int direction) {
    boolean vertical = direction % 2 == 0;
    dx = vertical ? 0 : 2 - direction;
    dy = vertical ? direction - 1 : 0;
  }
}

Move MoveUp = new Move(0);
Move MoveRight = new Move(1);
Move MoveDown = new Move(2);
Move MoveLeft = new Move(3);
