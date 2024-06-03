class Filter {
  float x;
  float y;
  float r;
  color c;
  boolean mouseOver = false;
  String strColor; 
  boolean isSelected = false;
  
  Filter (float x, float y, float r, color c, String strColor) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.c = c;
    this.strColor = strColor;
  }
  
  void update() {
    fill(c);
    circle(x, y, r * 2);
    isSelected = selectedFilter.equals(strColor);
    
    if (dist(x, y, mouseX, mouseY) < r) mouseOver = true;
    else mouseOver = false;
    
    if (isSelected) {
      println(String.format("%s selected", strColor));
      fill(c, 150);
      circle(x, y, r * 2.5);
      fill(255);
      int textHeight = 25;
      textSize(textHeight);
      text(strColor, x - textWidth(strColor) * 0.5, y + textHeight * 0.5);
    }
  }

}
