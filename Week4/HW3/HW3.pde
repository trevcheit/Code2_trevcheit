Table data;

void setup() {
  size(600, 600);
  data = loadTable("data.csv", "header");
  
  for (int i = 0; i < data.getRowCount(); i++){
    TableRow row = data.getRow(i);
    int x = row.getInt("x");
    int y = row.getInt("y");
    int size = row.getInt("size");
    int r = row.getInt("r");
    int g = row.getInt("g");
    int b = row.getInt("b");
    fill(color(r, g, b));
    ellipse(x, y, size, size);
  }
}

void draw() {
  
}

void mousePressed() {
  int s = int(random(100, 200));
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  fill(color(r, g, b));
  ellipse(mouseX, mouseY, s, s);
  TableRow newRow = data.addRow();
  newRow.setInt("x", mouseX);
  newRow.setInt("y", mouseY);
  newRow.setInt("size", s);
  newRow.setInt("r", r);
  newRow.setInt("g", g);
  newRow.setInt("b", b);
  saveTable(data, "data/data.csv");
}
