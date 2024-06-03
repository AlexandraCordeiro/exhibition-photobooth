class Button {
  int buttonWidth;
  int buttonHeight;
  int buttonX;
  int buttonY;
  boolean mouseOverButton = false;
  String str;
  
  Button(String str, int buttonWidth, int buttonHeight, int buttonX, int buttonY) {
    this.str = str;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.buttonX = buttonX;
    this.buttonY = buttonY;
  }
  
  void render() {
    if (mouseOverButton) fill(59, 59, 61);
    else fill(0);
    
    noStroke();
    rect(buttonX, buttonY, buttonWidth, buttonHeight, 5);
    
    fill(255);
    textFont(poppins);
    textSize(30);
    int textWidth = int(textWidth(str));
    int textHeight = 20;
    text(str, buttonX + (buttonWidth * 0.5) - (textWidth * 0.5), buttonY + (buttonHeight * 0.5) + (textHeight * 0.5));
  }
  
  void update() {
    if (mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      // mouse over button
      mouseOverButton = true;
    } 
    else {
      mouseOverButton = false;
    }
  }
}
