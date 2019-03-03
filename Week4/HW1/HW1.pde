// bryan ma for code 2 sp 19 A

String[] data;
Ellipse[] ellipses;

void setup() {
  data = loadStrings("dataPos.txt");
  
  size(600, 600);
  String[] splitData = data[0].split(",");
  ellipses = new Ellipse[splitData.length];
  String[] splitDataSiz = data[1].split(",");
  String[] splitDataRot = data[2].split(",");
  String[] splitDataCol = data[3].split(",");
  for (int i = 0; i < splitData.length; i++) {
    ellipses[i] = new Ellipse((50 + int(splitData[i]) * 100), int(splitDataSiz[i]), int(splitDataRot[i]), int(splitDataCol[i]));
  }
}

void draw() {
  
}
