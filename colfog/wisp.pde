public class SpookyThingDisperser {
  private PVector topBound;
  private PVector bottomBound;
  private Wisp[] wisps;
  
  public SpookyThingDisperser(PVector topBound, PVector bottomBound, int numOfWisps) {
    this.topBound = topBound;
    this.bottomBound = bottomBound;
    
    wisps = new Wisp[numOfWisps];
    
    populate();
  }
  
  public void populate() {
    float wWidth = random(40, 65);
    PVector wPos;
    for(int wi = 0; wi < wisps.length; wi++) {
      wPos = new PVector(random(topBound.x + wWidth, bottomBound.x - wWidth), 
                         random(topBound.y + wWidth, (bottomBound.y * .8) - wWidth));
      wisps[wi] = new Wisp(wPos, wWidth);
    }
  }
  
  public void drawSelf() {
    int haloCap = 20;
    for(int wi = 0; wi < wisps.length; wi++) {
      Wisp w = wisps[wi];
      
      strokeWeight(1);
      noFill();
      stroke(200);
      circle(w.position.x, w.position.y, w.diameter);
      
      float haloAngle;
      float smolHaloX = 0, smolHaloY = 0;
      for(int hi = 0; hi < haloCap; hi++) {
        haloAngle = TWO_PI / haloCap * hi;
        smolHaloX = w.diameter / 2 * cos(haloAngle);
        smolHaloY = w.diameter / 2 * sin(haloAngle);
        circle(smolHaloX + w.position.x, smolHaloY + w.position.y, w.diameter * .7);
      }
      
      //float d
      for(int cx = int(-w.diameter); cx <= int(w.diameter); cx++) 
        for(int cy = int(-w.diameter); cy <= int(w.diameter); cy++) 
          if(cx * cx + cy * cy <= w.diameter * w.diameter) {
            float distanceFromCenter = dist(w.position.x + cx, w.position.y + cy, w.position.x, w.position.y);
            stroke(map(distanceFromCenter, 0, w.diameter, 120, 200));
            point(w.position.x + cx, w.position.y + cy);
          }      
    }
  }
}
  
private class Wisp {
  private PVector position;
  private float diameter;
  
  public Wisp(PVector position, float diameter) {
    this.position = position;
    this.diameter = diameter;
  }
}
