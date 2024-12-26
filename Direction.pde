class Direction {
  int dx;
  int dy;
  
  Direction(int direction) {
    boolean vertical = direction % 2 == 0;
    dx = vertical ? 0 : 2 - direction;
    dy = vertical ? direction - 1 : 0;
  }
}

Direction DirectionUp = new Direction(0);
Direction DirectionRight = new Direction(1);
Direction DirectionDown = new Direction(2);
Direction DirectionLeft = new Direction(3);
Direction[] DIRECTIONS = {DirectionUp, DirectionRight, DirectionDown, DirectionLeft};
