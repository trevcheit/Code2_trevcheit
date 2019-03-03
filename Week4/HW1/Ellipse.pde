class Ellipse {
  int xPos;
  int size;
  int rotation;
  int col;
  int yPos = height/2;
  
  Ellipse(int _xPos, int _size, int _rotation, int _col) {
    xPos = _xPos;
    size = _size;
    rotation = _rotation;
    col = _col;
    ellipse(xPos, yPos, size, size);
    
    pushMatrix();
      translate(xPos, yPos-size/2);
      rotate(radians(rotation));
      fill(col);
      ellipse(size/2, size/2, size/2, size/2);
    popMatrix();
  }
  
}
