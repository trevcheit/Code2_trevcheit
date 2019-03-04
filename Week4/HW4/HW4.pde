// I'M GIVING UP ON THIS ONE. COMPLETELY AT A LOSS FOR WHERE TO BEGIN

int rows = 12;
int cols = 12;
int cellsize = 600/rows;

Block[][] blocks = new Block[rows][cols];

Table level1;
int[] tableInts;

//int[][] level = {
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0}, 
//  {0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0}, 
//  {0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0}, 
//  {0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0}, 
//  {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
//  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
//};

void setup() {
  size(600, 600);
  level1 = loadTable("level1.csv", "header");
  
  for (int i = 0; i < level1.getRowCount(); i++) {
    TableRow row = level1.getRow(i);
    tableInts[i] = row.getInt(i);
    println(tableInts[i]);
  }

  //for (int i = 0; i < level1.getRowCount(); i++) {
  //  for (int j = 0; j < level1.getColumnCount(); j++) {
  //    TableRow row = level1.getRow(i);
  //    println(row.getString(i));
      
  //    level[i][j] = row.getInt(i);
 
  //  }
  //}
}

void draw() {
  background(255);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      blocks[j][i].display();
    }
  }
}

class Block {
  PVector pos;
  float c;

  Block(int row, int col) {
    pos = new PVector(row * cellsize, col * cellsize);
  }

  void display() {
    fill(c);
    rect(pos.x, pos.y, cellsize, cellsize);
  }
}

class LightBlock extends Block {
  LightBlock(int row, int col) {
    super(row, col);
    c = 220;
  }
}

class DarkBlock extends Block {
  DarkBlock(int row, int col) {
    super(row, col);
    c = 50;
  }
}
