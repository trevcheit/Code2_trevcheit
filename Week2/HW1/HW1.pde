final int COLS = 25;
final int ROWS = 25;

Square[][] grid = new Square[COLS][ROWS];

int cellSize;

void setup() {
  size(600, 600);
  background(255);
  noStroke();
   
  cellSize = width/COLS; 
  
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      grid[i][j] = new Square(cellSize, new PVector(i*cellSize, j*cellSize));
    } 
  }
}

void draw() {
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      grid[i][j].display();
      grid[i][j].changeColor();
    }
  }
}
