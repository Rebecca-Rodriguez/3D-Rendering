PVector cameraPosition = new PVector();
PVector lookatTarget = new PVector();
int gridSize = 100;
int gridUnit = 10;

boolean check = false;

Camera c = new Camera();
Box box = new Box();
PShape halfMonster;
PShape wireframeMonster;


void setup()
{
  size(1600, 1000, P3D);

  // create projection matrix to convert 3D to 2D
  perspective(radians(50.0f), width/(float)height, 0.1, 1000);

  // cubes
  c.AddLookAtTarget(new PVector(-100, 0, 0));

  // triangle fans
  c.AddLookAtTarget(new PVector(-50, 0, 0));

  // half-scale monster
  c.AddLookAtTarget(new PVector(0, 0, 0));

  // wireframe monster
  c.AddLookAtTarget(new PVector(75, 0, 0));

  halfMonster = loadShape("monster.obj");
  halfMonster.setFill(color(198, 229, 92));

  wireframeMonster = loadShape("monster.obj");
  wireframeMonster.setFill(false);
  wireframeMonster.setStroke(true);
  wireframeMonster.setStroke(color(0));
  wireframeMonster.setStrokeWeight(2.0f);

  lookatTarget = new PVector(-100, 0, 0);

  cameraPosition = new PVector(-100, 0, 0);
}

void draw()
{
  background(100, 100, 100);

  cameraPosition = c.Update(cameraPosition, lookatTarget);

  //camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
  camera(cameraPosition.x, cameraPosition.y, cameraPosition.z,
    lookatTarget.x, lookatTarget.y, lookatTarget.z,
    0, 1, 0);

  // draw grid
  drawGrid();

  // three boxes
  box.DrawBoxes();

  // triangle fans
  drawTriangleFans();

  // half-scale monster
  drawMonster(0, 0.5, halfMonster);

  // wireframe monster
  drawMonster(75, 0, wireframeMonster);

  if (check)
  {
     c.CycleTarget();
     lookatTarget = c.GetCurrentTarget();
     check = false;
  }
}

void keyPressed()
{
    if (key == ' ')
    {
      check = true;
    }
}

void mouseWheel(MouseEvent e)
{
  float event = e.getCount();
  c.Zoom(event);
}

void drawGrid()
{
  for (int x = -gridSize; x <= gridSize; x += gridUnit)
  {
    for (int z = -gridSize; z <= gridSize; z += gridUnit)
    {
      // white lines
      strokeWeight(1);
      stroke(255);

      // lines on X-axis
      pushMatrix();
      translate(x, 0, 0);
      line(0, 0, -z, 0, 0, z);
      popMatrix();

      // lines on Z-axis
      pushMatrix();
      translate(0, 0, z);
      line(-x, 0, 0, x, 0, 0);
      popMatrix();

      strokeWeight(3);

      // RED line
      stroke(255, 0, 0);
      line(-x, 0, 0, x, 0, 0);

      // BLUE line
      stroke(0, 0, 255);
      line(0, 0, -z, 0, 0, z);

      strokeWeight(0);
    }
  }
}

void drawTriangleFans()
{
  strokeWeight(3);
  stroke(0);
  colorMode(HSB, 360, 100, 100);
  float degrees;
  float angle;
  int radius = 10;
  translate(-50, -radius, 0);

  // 20 segments
  pushMatrix();
  translate(-radius, 0, 0);
  beginShape(TRIANGLE_FAN);
  degrees = 360.0f / 20;
  angle = 0;
  for (int i = 0; i < 360; i += degrees)
  {
    float x = cos(radians(angle)) * radius;
    float y = sin(radians(angle)) * radius;
    vertex(x, y, 0);
    fill(i, 100, 100);
    angle += degrees;
  }
  endShape();
  popMatrix();

  // 6 segments
  pushMatrix();
  translate(radius, 0, 0);
  beginShape(TRIANGLE_FAN);
  degrees = 360.0f / 6;
  angle = 0;
  for (int i = 0; i < 360; i += degrees)
  {
    float x = cos(radians(angle)) * radius;
    float y = sin(radians(angle)) * radius;
    vertex(x, y, 0);
    fill(i, 100, 100);
    angle += degrees;
  }
  endShape();
  popMatrix();

  // move origin back to center
  translate(50, radius, 0);
  colorMode(RGB, 255);
  strokeWeight(0);
}

void drawMonster(int xTranslate, float scaleVal, PShape monster)
{
  pushMatrix();
  translate(xTranslate, 0, 0);
  if (scaleVal > 0)
    scale(scaleVal);
  rotate(PI);
  shape(monster);
  popMatrix();
}
