// bryan ma for code 2 sp19 A

// replace the sizes integer array with csv data loaded externally.

Table sizes;
Rectangle rects;

void setup() {
  size(800, 600);
  sizes = loadTable("data.csv", "header");
  
  for (int i = 0; i < sizes.getRowCount(); i++){
    TableRow row = sizes.getRow(i);
    float h = row.getFloat("size");
    float x = map(i, 0, sizes.getRowCount() - 1, 100, 700);
    
    rects = new Rectangle(x, h);
  }
}

void draw() {
}
