public class Forest {
  private PVector topBound;
  private PVector bottomBound;
  
  private Pillar[] pillars;
  
  public Forest(PVector topBound, PVector bottomBound, int numberOfTrees) {
    this.topBound = topBound;
    this.bottomBound = bottomBound;
    
    this.pillars = new Pillar[numberOfTrees];
    
    populate();
  }
  
  public void populate() {
    PVector pPosition;
    float pWidth;
    float pHeight;
    float pColor;
    
    int pillarIndex = 0;
    do {
      pWidth = random(20, 40);
      pHeight = map(pillarIndex, 0, pillars.length, bottomBound.y * .1, bottomBound.y * .75);
      pPosition = new PVector(random(topBound.x + pWidth / 2, bottomBound.x - pWidth), topBound.y);
      pColor = map(pHeight, topBound.y, bottomBound.y * .75, 75, 150);
      
      pillars[pillarIndex] = new Pillar(pPosition, pWidth, pHeight, pColor);
      for(int colliderIndex = 0; colliderIndex < pillarIndex; colliderIndex++)
        if(pillars[pillarIndex].isCovered(pillars[colliderIndex], 10))
          pillarIndex--;
        
      pillarIndex++;
    } while(pillarIndex < pillars.length);
  }
  
  public void drawSelf() {
    noStroke();
    
    Pillar p;
    for(int pillarIndex = 0; pillarIndex < pillars.length; pillarIndex++) {
      p = pillars[pillarIndex];
      
      fill(p.pillarColor);
      rect(p.position.x, p.position.y , p.pillarWidth, p.pillarHeight);
    }
  }
}

private class Pillar {
  public PVector position;
  private float pillarWidth;
  private float pillarHeight;
  private float pillarColor;
  
  
  public Pillar(PVector position, float pillarWidth, float pillarHeight, float pillarColor) {
    this.position = position;
    this.pillarWidth = pillarWidth;
    this.pillarHeight = pillarHeight;
    this.pillarColor = pillarColor;
  }
  
  public boolean isCovered(Pillar collider, float bw) {
    return !(this.position.x + this.pillarWidth + bw < collider.position.x ||
          collider.position.x + collider.pillarWidth + bw < this.position.x ||
          this.position.y + this.pillarHeight + bw < collider.pillarHeight ||
          collider.position.y + collider.pillarHeight + bw < this.pillarHeight);
  }
}
