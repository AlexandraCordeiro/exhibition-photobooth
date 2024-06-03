
import processing.video.*;
import processing.core.PApplet.*;
import processing.pdf.*;

Capture video;

// video capture size
int w_video = 1280;
int h_video = 720;

int timer = 3;

// fonts
PFont monospace, handwritten, title_font, jeanLuc, poppins;

// svg and images
PShape teresa;
PImage logo;

// receipt dimensions
int w = 400;
int h = 2000;


// utils
int numPhotos = 0;
int results = 0;

boolean initPage = true;
boolean filterPage = false;
boolean videoPage = false;
boolean finalPage = false;

Button buttonStart, buttonNext, buttonTryAgain;
Filter blueFilter, pinkFilter, yellowFilter;
Receipt receipt;

String selectedFilter = "";
color selectedColor;

void setup() {
  size(1280, 720);
  video = new Capture(this, w_video, h_video);
  // load fonts
  title_font = loadFont("NimbusSansBeckerPBla-48.vlw");
  handwritten = loadFont("ReenieBeanie-48.vlw");
  monospace = loadFont("SpaceMono-Regular-48.vlw");
  jeanLuc = loadFont("JeanLuc-Bold-150.vlw");
  poppins = loadFont("Poppins-Medium-48.vlw");
  
  // load svg and images
  teresa = loadShape("teresa_sdralevich.svg");
  logo = loadImage("ts_1.png", "png");
  
  initButtons();
  initFilters();
}

void draw () {
  if (initPage) handleInitPage();
  if (filterPage) handleFilterPage();
  if (videoPage) handleVideoCapture();
  if (finalPage) handleFinalPage();
}


void mouseClicked() {
  
  if (buttonStart.mouseOverButton && initPage) {
    println("init page");
    initPage = false;
    filterPage = true;
  }
  
  if (filterPage && buttonNext.mouseOverButton) {
    println("Video capture startig now...");
    video.start(); 
    filterPage = false;
    videoPage = true;
  }

  if (buttonTryAgain.mouseOverButton && finalPage) {
    video.stop();
    initPage = true;
    filterPage = false;
    videoPage = false;
    finalPage = false;
    numPhotos = 0;
    timer = 3;
    selectedFilter = "";
    selectedColor = color(0);
    initButtons();
    initFilters();
  }
  
  if (blueFilter.mouseOver) {
    selectedFilter = "blue";
    selectedColor = blueFilter.c;
  } 
  if (pinkFilter.mouseOver) {
    selectedFilter = "pink";
    selectedColor = pinkFilter.c;
  } 
  if (yellowFilter.mouseOver) {
    selectedFilter = "yellow";
    selectedColor = yellowFilter.c;
  } 
}

void initButtons() {
  
  int buttonWidth = 140;
  int buttonHeight = 55;
  buttonStart = new Button("start", buttonWidth, buttonHeight, int(width * 0.5 - buttonWidth * 0.5), int(height * 0.85 - buttonHeight * 0.5));
  
  buttonWidth = 160;
  buttonNext = new Button("next", buttonWidth, buttonHeight, int(width * 0.5 - buttonWidth * 0.5), int(height * 0.85 - buttonHeight * 0.5));
  
  buttonTryAgain = new Button("try again", buttonWidth, buttonHeight, int(width * 0.5 - buttonWidth * 0.5), int(height * 0.85 - buttonHeight * 0.5));
}


void initFilters() {
  color blue = color(160, 202, 226);
  color red = color(237, 152, 172);
  color yellow = color(230, 184, 86);
  
  int r = 100;
  
  blueFilter = new Filter(width * 0.5 - r * 2.5, height * 0.5, r, blue, "blue");
  pinkFilter = new Filter(width * 0.5, height * 0.5, r, red, "pink");
  yellowFilter = new Filter(width * 0.5 + r * 2.5, height * 0.5, r, yellow, "yellow");
}

void handleInitPage() {
  background(255);
  // add logo
  float newWidth = logo.width;
  float newHeight = logo.height;
  smooth();
  image(logo, int(width * 0.5 - newWidth * 0.5), int(height * 0.5 - newHeight * 0.5), newWidth, newHeight);
  
  // photobooth text
  fill(0);
  textFont(jeanLuc);
  String txt = "Photobooth";
  int textHeight = 100;
  textSize(textHeight);
  float textWidth = textWidth(txt);
  text(txt, int(width * 0.5 - textWidth * 0.5), int(height * 0.6 + textHeight), textWidth);
  
  // button
  fill(255, 0, 0);
  buttonStart.render();
  buttonStart.update();
}

void handleFilterPage() {
  background(255);
  fill(0, 0, 255);
  
  textFont(poppins);
  textSize(35);
  fill(0);
  String text = "Choose one of the following filters";
  float textWidth = textWidth(text);
  text(text, width * 0.5 - textWidth * 0.5, height * 0.2);
  
  // render filter options
  blueFilter.update();
  pinkFilter.update();
  yellowFilter.update();
  
  // next button
  fill(255, 0, 0);
  buttonNext.render();
  buttonNext.update();
}

void handleVideoCapture() {
  if (video.available() == true) {
    video.read();
    tint(selectedColor);
    image(video, 0, 0);
  }
  
  // decrease timer
  if (frameCount % 60 == 0) {
    timer--;
  }
  
  // remove counter visibility
  if (timer == 0 || timer == -1) {
    text("", width * 0.5, height * 0.5);
  }
  // show timer (3, 2, 1...)
  else {
    fill(0);
    textFont(jeanLuc);
    textSize(150);
    text(nfc(timer), width * 0.5, height * 0.5);
  }
  
  // save photo
  if (timer == -1) {
    saveFrame(String.format("data/picture-%d.jpg", numPhotos));
    println(String.format("Saving picture-%d.jpg", numPhotos));
    numPhotos++;
    
    // max photos reached
    if (numPhotos == 3) {
      println("Closing video window...");
      background(255);
      video.stop();
      // create receipt
      receipt = new Receipt(selectedColor);
      videoPage = false;
      finalPage = true;
    }
    
    // reset timer
    timer = 3;
  }
}


void handleFinalPage() {
  background(255);
  
  float size = 300;
  float imgHeight = (size * 375)/278;
  shape(teresa,width * 0.5 - size * 0.5, height * 0.05, size, imgHeight);
  // thank you message
  fill(0);
  textFont(jeanLuc);
  String txt = "Thank You!";
  int textHeight = 100;
  textSize(textHeight);
  float textWidth = textWidth(txt);
  text(txt, int(width * 0.5 - textWidth * 0.5), int(height * 0.6 + textHeight), textWidth);
  
  // try again button
  fill(255, 0, 0);
  buttonTryAgain.render();
  buttonTryAgain.update();
}
