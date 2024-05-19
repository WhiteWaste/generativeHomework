// Processing sketch to simulate burning wood using noise, updated on space bar press
FogWall fw;
Forest pf;
SpookyThingDisperser std;

PVector fogPos;
PVector fogSize;
PVector topBound;
PVector bottomBound;

void setup() {
  size(1080, 720);
  
  fw = new FogWall(810, 490, 405, 245);
  
  fogPos = fw.getPosition();
  fogSize = fw.getSize();
  topBound = fw.getTopBound();
  bottomBound = fw.getBottomBound();

  pf = new Forest(topBound, bottomBound, 25);
  std = new SpookyThingDisperser(topBound, bottomBound, 3);
}

void draw() {
  background(230);
  
  pf.drawSelf();
  fw.drawSelf();
  std.drawSelf();
}

void mousePressed() {
  saveFrame();
}

void keyPressed() {
  if (key == ' ') {
    fw.updateFog();
    pf.populate();
    std.populate();
  }
}
