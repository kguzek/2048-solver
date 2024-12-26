class Tile {
  int value;
  
  Tile() {
    if (random(1) < Settings.generate4Probability) {
      value = 4;
    } else {
      value = 2;
    }
  }
  
  Tile(int value) {
    this.value = value;
  }
  
  void fillColor() {
    // Stage is between 0 and 11
    int stage = floor(log(value) / log(2));
    int r = 255 / 11 * stage;
    int b = min(255, r * 2);
    int g = 255 - b;
    fill(r, g, b);
  }
  
  void draw(int x, int y) {
    int drawX = x * (Settings.columnWidth + Settings.padding) + Settings.padding;
    int drawY = Settings.ribbonHeight + y * (Settings.rowHeight + Settings.padding) + Settings.padding;
    fillColor();
    noStroke();
    rect(drawX, drawY, Settings.columnWidth, Settings.rowHeight);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(value, drawX + Settings.columnWidth / 2, drawY + Settings.rowHeight / 2);
  }
}
