JSONObject data;
JSONArray w;
JSONObject element;
JSONObject sys;
String country;
String main;
String description;
String name;

int lat;
int lon;
String eastWest;
String northSouth;
String latString;
String lonString;

Weather weather;

void initSketch(){
  lat = int(random(-90, 90));
  lon = int(random(-180, 180));
  
  if(lat < 0){ latString = str(-lat); }
  else { latString = str(lat); }
  
  if(lon < 0){ lonString = str(-lon); }
  else { lonString = str(lon); }
  
  data = loadJSONObject("http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&APPID=4017330b10f41b6e7fa256d993cced90");
  w = data.getJSONArray("weather");
  element = w.getJSONObject(0);
  main = element.getString("main");
  description = element.getString("description");
  name = data.getString("name");
  sys = data.getJSONObject("sys");
  country = sys.getString("country");
  
  weather = new Weather(main, description);
}

void setup() { 
  size(600, 600);
  
  initSketch();
  
  //lat = int(random(-90, 90));
  //lon = int(random(-180, 180));
  
  //if(lat < 0){ latString = str(-lat); }
  //else { latString = str(lat); }
  
  //if(lon < 0){ lonString = str(-lon); }
  //else { lonString = str(lon); }
  
  //data = loadJSONObject("http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&APPID=4017330b10f41b6e7fa256d993cced90");
  //w = data.getJSONArray("weather");
  //element = w.getJSONObject(0);
  //main = element.getString("main");
  //description = element.getString("description");
  //name = data.getString("name");
  //sys = data.getJSONObject("sys");
  //country = sys.getString("country");
  
  //weather = new Weather(main, description);
  
  ellipseMode(CENTER);
  noStroke();
}
  
void draw() {
  
  if(lat > 0) { northSouth = "N"; }
  else if(lat < 0) { northSouth = "S"; }
  else if(lat == 0) { northSouth = ""; }
  if(lon > 0) { eastWest = "E"; }
  else if(lon < 0) { eastWest = "W"; }
  else if(lon == 0) { eastWest = ""; }
  
  weather.display();
  
  fill(0);
  textSize(20);
  text(name, 20, height-100);
  text(latString + northSouth + ", " + lonString + eastWest, 20, height-70);
  textSize(12);
  text(main, 20, height-40);
  text(description, 20, height-20);
}

void keyPressed(){
  initSketch();
}

class Weather {
  String main;
  String description;
  Cloud[] clouds;
  Rain[] rain;
  Snow[] snow;
  int num;
  
  Weather(String _main, String _description){
    main = _main;
    description = _description;
    
    if(main.equals("Clouds")){
      if(description.equals("few clouds")){ num = 5; }
      else if(description.equals("scattered clouds")){ num = 10; }
      else if(description.equals("broken clouds")){ num = 20; }
      else{ num = 30; }
      
      clouds = new Cloud[num];
      
      for(int i = 0; i < clouds.length; i++){
        clouds[i] = new Cloud();
      }
    }
    
    if(main.equals("Rain") || main.equals("Drizzle") || main.equals("Thunderstorm")){
      if(description.equals("light rain") 
        || description.equals("light intensity drizzle") 
        || description.equals("thunderstorm with light rain")
        || description.equals("light thunderstorm")
        || description.equals("thunderstorm with light drizzle")){ num = 100; }
      else if(description.equals("moderate rain") 
        || description.equals("drizzle")){ num = 300; }
      else{ num = 500; }
      
      rain = new Rain[num];
      
      for(int i = 0; i < rain.length; i++){
        rain[i] = new Rain();
      }
    }
    
    if(main.equals("Snow")){
      if(description.equals("light snow")){ num = 100; }
      else if(description.equals("snow")){ num = 300; }
      else{ num = 500; }
      
      snow = new Snow[num];
      
      for(int i = 0; i < snow.length; i++){
        snow[i] = new Snow();
      }
    }
  }
  
  void display() {
    if(main.equals("Clear")){
      background(74, 144, 226);
      fill(248, 209, 28);
      ellipse(width/1.5, height/4, 200, 200);
    }
    
    if(main.equals("Clouds")){
      background(74, 144, 226);
      for(int i = 0; i < clouds.length; i++){
        clouds[i].display();
      }
    }
    
    if(main.equals("Rain") 
      || main.equals("Drizzle") 
      || main.equals("Thunderstorm")){
        background(188, 198, 211);
        for(int i = 0; i < rain.length; i++){
          rain[i].display();
        }
    }
    
    if(main.equals("Snow")){
      background(224, 228, 232);
      for(int i = 0; i < snow.length; i++){
        snow[i].display();
      }
    }
    
    if(main.equals("Mist") 
      || main.equals("Smoke") 
      || main.equals("Haze") 
      || main.equals("Fog") 
      || main.equals("Squall") 
      || main.equals("Tornado")){
        background(225);
    }
    
    if(main.equals("Dust") 
      || main.equals("Sand") 
      || main.equals("Ash")){
        background(216, 210, 181);
    }
  } 
}

class Cloud {
  float xPos = random(0, width);
  float yPos = random(0, height);
  float size = random(50, 150);
  float speed = random(.1, 1);
  
  void display(){
    fill(255);
    ellipse(xPos, yPos, size, size);
    ellipse(xPos + size/2, yPos+size/6, size/1.5, size/1.5);
    ellipse(xPos - size/2, yPos+size/6, size/1.5, size/1.5);
    xPos += speed;
    
    if(xPos > width + size){
      xPos = -size;
    }
  }
}

class Rain {
  float xPos = random(0, width);
  float yPos = random(0, height);
  float size = random(1, 3);
  float speed = random(10, 25);
  
  void display() {
    fill(79, 127, 182);
    ellipse(xPos, yPos, size, size);
    yPos += speed;
    
    if(yPos > height + size){
      yPos = -size;
    }
  }
}

class Snow {
  float xPos = random(0, width);
  float yPos = random(0, height);
  float size = random(5, 10);
  float speed = random(2, 6);
  
  void display() {
    fill(255);
    ellipse(xPos, yPos, size, size);
    yPos += speed;
    
    if(yPos > height + size){
      yPos = -size;
    }
  }
}
