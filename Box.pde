class Box
{
  PVector[] points = new PVector[8];    // box has 8 points

  Box()
  {
    points = new PVector[8];
    for (int i = 0; i < 8; i++)
    {
      points[i] = new PVector();
    }
    SetPoints();
  }

  void SetPoints()
  {
    float x = 0.5;
    float y = 0.5;
    float z = 0.5;

    points[0].set(-x, -y, z);
    points[1].set(-x, y, z);
    points[2].set(x, y, z);
    points[3].set(x, -y, z);
    points[4].set(-x, -y, -z);
    points[5].set(-x, y, -z);
    points[6].set(x, y, -z);
    points[7].set(x, -y, -z);
  }

  void DrawBoxes()
  {
    strokeWeight(0);
    translate(-100, 0, 0);
    pushMatrix();
    scale(5, 5, 5);
    DrawBox();
    popMatrix();

    pushMatrix();
    translate(-10, 0, 0);
    DrawBox();
    popMatrix();

    pushMatrix();
    translate(10, 0, 0);
    scale(10, 20, 10);
    DrawBox();
    popMatrix();

    // move origin back to center
    translate(100, 0, 0);
  }

  void DrawBox()
  {
    PVector[] triangle;
    int colorValue;

    triangle = new PVector[]{points[0], points[1], points[2]};
    colorValue = color(255, 254, 84);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[0], points[2], points[3]};
    colorValue = color(116, 250, 78);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[0], points[3], points[4]};
    colorValue = color(171, 206, 186);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[7], points[3], points[4]};
    colorValue = color(229, 115, 45);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[0], points[1], points[4]};
    colorValue = color(177, 179, 158);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[1], points[4], points[5]};
    colorValue = color(35, 19, 194);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[2], points[3], points[7]};
    colorValue = color(230, 78, 57);
    DrawTriangle(triangle, colorValue);

    triangle = new PVector[]{points[2], points[6], points[7]};
    colorValue = color(87, 128, 194);
    DrawTriangle(triangle, colorValue);
    
    triangle = new PVector[]{points[4], points[6], points[7]};
    colorValue = color(148, 66, 174);
    DrawTriangle(triangle, colorValue);
    
    triangle = new PVector[]{points[4], points[6], points[5]};
    colorValue = color(56, 127, 193);
    DrawTriangle(triangle, colorValue);
    
    triangle = new PVector[]{points[1], points[2], points[5]};
    colorValue = color(230, 53, 245);
    DrawTriangle(triangle, colorValue);
    
    triangle = new PVector[]{points[6], points[2], points[5]};
    colorValue = color(233, 52, 35);
    DrawTriangle(triangle, colorValue);
  }

  void DrawTriangle(PVector[] points, int colorValue)
  {
    beginShape(TRIANGLE);
    fill(colorValue);
    for (int i = 0; i < 3; i++) {
      vertex(points[i].x, points[i].y, points[i].z);
    }
    endShape(CLOSE);
  }
};
