//state = screen
//text to display for each screen (state representation)
//options to choose for each screen (state transitions)

//string for each text
//string for each option - corresponds to a keypress

int state = 0;

Scene[] scenes = new Scene[7];

JSONArray descriptions;
JSONArray optionArray;
JSONArray optionTargetsArray;
JSONArray bgColorsArray;
color bgColor;

JSONObject sceneData;

void setup(){
  size(600, 600);
  
  //LOADING JSON FILE
  sceneData = loadJSONObject("data.json");
    
  for (int i = 0; i < scenes.length; i++){ 
    //DESCRIPTIONS ARRAY
    descriptions = sceneData.getJSONArray("descriptions");
    
    //OPTIONS CONTAINER ARRAY
    optionArray = sceneData.getJSONArray("options").getJSONArray(i);
    //FILLING OPTIONS CONTAINER ARRAY WITH OPTIONS ARRAYS FOR INDIVIDUAL SCENES
    String[] options = new String[optionArray.size()];
    for (int j = 0; j < options.length; j++){
      options[j] = optionArray.getString(j);
    }
    
    //OPTIONS TARGETS CONTAINER ARRAY
    optionTargetsArray = sceneData.getJSONArray("optionTargets").getJSONArray(i);
    //FILLING OPTION TARGETS CONTAINER ARRAY WITH OPTION TARGETS ARRAYS FOR INDIVIDUAL SCENES
    int[] optionTargets = new int[optionTargetsArray.size()];
    for (int j = 0; j < optionTargets.length; j++){
      optionTargets[j] = optionTargetsArray.getInt(j);
    }
    
    //BG COLOR CONTAINER ARRAY
    bgColorsArray = sceneData.getJSONArray("bgColors").getJSONArray(i);
    int[] bgColors = new int[bgColorsArray.size()];
    for (int j = 0; j < bgColors.length; j++){
      bgColors[j] = bgColorsArray.getInt(j);
    }
      
    //SCENE CONSTRUCTOR
    scenes[i] = new Scene(descriptions.getString(i), options, optionTargets, bgColors);
  }
}

void draw(){
  for(int i = 0; i < scenes[state].bgColors.length; i++) {
    background(color(scenes[state].bgColors[0], scenes[state].bgColors[1], scenes[state].bgColors[2]));
  }
  
  textSize(40);
  fill(0);
  text(scenes[state].displayText, 40, 40, 450, 300);
  
  textSize(24);
  int i = 0;
  for(String option : scenes[state].options) {
    text(option, 40, 450 + i * 50);
    i++;
  }
}

void keyPressed(){ 
  for(int i = 0; i < scenes[state].options.length; i++){
    if(keyCode - 49 == i){
      state = scenes[state].optionTargets[i];
    }
  }
}

class Scene {
  String displayText;
  String[] options;
  int[] optionTargets;
  int[] bgColors;
  
  Scene(String txt, String[] opt, int[] targets, int[] bgCol) {
    displayText = txt;
    options = opt;
    optionTargets = targets;
    bgColors = bgCol;
  }
}
