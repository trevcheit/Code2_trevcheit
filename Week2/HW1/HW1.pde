// code 2 sp 19, bryan ma

// create two constant integers to store how many columns and rows the grid will have
final int COLS = 25;
final int ROWS = 25;

Square[][] grid = new Square[COLS][ROWS];

// create but don't assign a cellsize variable, we'll do that in setup()
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
