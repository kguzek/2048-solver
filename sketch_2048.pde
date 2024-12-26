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
  switch (key) {
  case CODED:
    switch (keyCode) {
      case UP:
        player.move(0, -1);
        break;
      case RIGHT:
        player.move(1, 0);
        break;
      case DOWN:
        player.move(0, 1);
        break;
      case LEFT:
        player.move(-1, 0);
        break;
    }
  }
}
