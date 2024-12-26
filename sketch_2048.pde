BotOrPlayer player;

void settings() {
  size(Settings.screenWidth, Settings.screenHeight);
}

void setup() {
  // player = new Bot();
  player = new Player();
}

void draw() {
  background(216, 216, 255);
  player.draw();
}

void keyPressed() {
  int pressedKey = key;
  if (pressedKey == CODED) {
    pressedKey = keyCode;
  }
  switch(pressedKey) {
    case UP:
      case 'w':
      player.move(DirectionUp);
      break;
    case RIGHT:
      case 'd':
      player.move(DirectionRight);
      break;
    case DOWN:
      case 's':
      player.move(DirectionDown);
      break;
    case LEFT:
      case 'a':
      player.move(DirectionLeft);
      break;
    case ' ':
      player.reset();
      break;
  }
}