class Receipt extends PApplet {
  PGraphicsPDF pdf;
  color selectedColor;
  
  public Receipt(color selectedColor) {
    super();
    this.selectedColor = selectedColor;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public void settings() {
    // outpult folder
    String outputFolder = "C:\\Users\\Alexandra\\Documents\\MDM\\2o semestre\\odm\\photobooth\\outputs\\";
    String outputDir = String.format("%sreceipt-%dh%dm.pdf", outputFolder, hour(), minute());
    size(400, 2000 , PDF, outputDir);
    smooth();
  }
  
  
  public void setup() {
    windowTitle("Receipt");    
    textMode(SHAPE);
    String[] fontList = PFont.list();
    printArray(fontList);
    PFont monospace, handwritten, jeanLuc;
    monospace = createFont("Space Mono Regular", 48);
    handwritten = createFont("Reenie Beanie", 48);
    title_font = createFont("Nimbus_Sans_Becker_PBla", 48);
    jeanLuc = createFont("JeanLuc-Bold", 48);
    results++;

    
    background(255);
    fill(selectedColor);
    
    // TITLE
    textFont(jeanLuc);
    textAlign(CENTER, CENTER);
    String titleLine1 = "TERESA";
    String titleLine2 = "SDRALEVICH";
    float box = textWidth(titleLine2);
    int titleTopMargin = 50;

    text(titleLine1, width / 2, titleTopMargin);
    text(titleLine2, width / 2, titleTopMargin + 50, 100);
    
    // info
    textAlign(LEFT, CENTER);
    textFont(monospace, 16);
    String currentDate = String.valueOf(day()) + "/" + String.valueOf(month()) + "/" + String.valueOf(year());
    println(currentDate);
    String info = String.format("******* ART EXHIBITION ******* \n\nDate: %s \nAddress: Galeria R/C DARQ \n\n******************************", currentDate);
    float infoTopMargin = titleTopMargin + 45;
    box = textWidth(info);
    text(info, w*0.5-box*0.5, infoTopMargin , box, box);
    
    
    // DESIGNER ILLUSTRATION & QUOTE
    float size = 200;
    float imgTopMargin = infoTopMargin + box * 0.8;
    // float imgRatio = 375/278;
    float imgHeight = (size * 375)/278;
    shape(teresa, w*.5 - size*.5, imgTopMargin, size, imgHeight);
    
    
    // quote
    textFont(handwritten, 30);
    String quote = "My  biggest challenge as a designer is to serve the cause by creating images that may push  mentalities a few inches forward";
    float quoteTopMargin = infoTopMargin + imgHeight*1.8;
    text(quote, w*0.5-box*0.5, quoteTopMargin, box, box);
    
    // load photobooth pictures
    
    // data folder
    String folderDir = "C:\\Users\\Alexandra\\Documents\\MDM\\2o semestre\\odm\\photobooth\\data\\";
    float picTopMargin = quoteTopMargin + box*0.9;
    
    float newImgWidth = 0;
    float newImgHeight = 0;
    
    for (int i = 0; i < numPhotos; i++) {
      String imgDir = String.format("%spicture-%d.jpg", folderDir, i + 1);
      PImage img = loadImage(imgDir);
      newImgWidth = img.width/4;
      newImgHeight= img.height/4;
      
      image(img, w*0.5 - (newImgWidth)*.5, picTopMargin, newImgWidth, newImgHeight);
      
      String figure = String.format("________________________  Fig.%d", i+1);
      textFont(monospace, 16);
      box = textWidth(figure);
      text(figure, w*0.5-box*0.5, picTopMargin + (newImgHeight) ,box, box/4);
      
      picTopMargin += newImgHeight * 1.5;
    }
    
    // FINAL SUM
    textFont(monospace, 16);
    text(String.format("------------------------------\nITEM COUNT                   3\nTOTAL                THANK YOU\n------------------------------"), w*0.5-box*0.5, picTopMargin + box/4 ,box, box/4);
    
    
    PImage codeBar = loadImage(String.format("%scode-bar.png", folderDir));
    image(codeBar, w*.5 - (codeBar.width*.5), h - (codeBar.height));
  }

}
