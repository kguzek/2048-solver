Player player;

void settings() {
  size(Settings.screenWidth, Settings.screenHeight);
}

void setup() {
  player = new Player();
}

void draw() {
  background(240);
  player.draw();
}

void keyPressed() {
  if (player.gameOver) return;
  int pressedKey = key;
  if (pressedKey == CODED) {
    pressedKey = keyCode;
  }
  switch(pressedKey) {
    case UP:
      case 'w':
      player.move(0, -1);
      break;
    case RIGHT:
      case 'd':
      player.move(1, 0);
      break;
    case DOWN:
      case 's':
      player.move(0, 1);
      break;
    case LEFT:
      case 'a':
      player.move( -1, 0);
      break;
  }
}
