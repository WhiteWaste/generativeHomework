public class FogWall {
  // positioning:
  private float positionX;
  private float positionY;
  private float sizeX;
  private float sizeY;
  
  // drawing:
  private int borderWidth;
  private float resolutionX;
  private float resolutionY;
  private float scaleX;
  private float scaleY;
  private float fogArray[][];
  
  
  public FogWall(float sizeX, float sizeY, float resX, float resY) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    positionX = width * .5 - sizeX * .5;
    positionY = height * .5 - sizeY * .5;
    
    borderWidth = 5;
    
    resolutionX = resX;
    resolutionY = resY;
    
    scaleX = sizeX / resolutionX;
    scaleY = sizeY / resolutionY;
    fogArray = new float[(int) resX][(int) resY];
    
    updateFog();
  }
  
  public void drawSelf() {
    // the fog effect:
    noStroke();
    for(int r = 0; r < fogArray.length; r++) {
      for(int c = 0; c < fogArray[r].length; c++) {
        float colorMap = map(fogArray[r][c], 0, 1, 100, 255);
        float alpha = map(fogArray[r][c], 0, 1, 50, 255);  // Vary alpha for transparency effect
        
        fill(colorMap, colorMap / 2, 0, alpha);
        fill(colorMap, alpha);
        rect(positionX + r * scaleX, positionY + c * scaleY, scaleX, scaleY);
      }
    }
    
    // the border rectangle:
    stroke(0);
    noFill();
    strokeWeight(borderWidth);
    rect(positionX, positionY, sizeX, sizeY);
  }
 
  public void updateFog() {
    for(int r = 0; r < fogArray.length; r++) {
      for(int c = 0; c < fogArray[r].length; c++) {
        fogArray[r][c] = noise(r * .1, c * .1, millis() * .0005);
      }
    }
  }
  
  public PVector getPosition() {
    return new PVector(positionX, positionY);
  }
  
  public PVector getSize() {
    return new PVector(sizeX, sizeY);
  }
  
  public PVector getTopBound() {
    return new PVector(positionX + borderWidth / 2, positionY + borderWidth / 2);
  }
  
  public PVector getBottomBound() {
    return new PVector(positionX + sizeX - borderWidth / 2, positionY + sizeY - borderWidth / 2);
  }  
}
