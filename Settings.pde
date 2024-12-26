static class Settings {
  static int columns = 4;
  static int rows = 4;
  static int columnWidth = 200;
  static int rowHeight = 200;
  static int padding = 10;
  static int ribbonHeight = 50;
  static int screenWidth = columns * columnWidth + padding * 5;
  static int screenHeight = ribbonHeight + rows * rowHeight + padding * 5;
  
  static int startingTiles = 2;
  static int textBlinkDuration = 50;
  // The probability of generating a 4 instead of a 2
  static float generate4Probability = 0.1;
}
