class Camera
{
  ArrayList<PVector> targetLocations = new ArrayList<PVector>();
  int count = 0;
  float scaleFactor;
  int radius = 200;


  PVector Update(PVector cameraPosition, PVector lookatTarget)
  {

    float camX = map(mouseX, 0, width - 1, 0, 360);
    float camY = map(mouseY, 0, height - 1, 1, 179);

    float derivedX = radius * cos(radians(camX)) * sin(radians(camY));
    float derivedY = radius * cos(radians(camY));
    float derivedZ = radius * sin(radians(camY)) * sin(radians(camX));

    cameraPosition.x = lookatTarget.x + derivedX;
    cameraPosition.y = lookatTarget.y + derivedY;
    cameraPosition.z = lookatTarget.z + derivedZ;
    return cameraPosition;
  }

  void AddLookAtTarget(PVector lookatTarget)
  {
    targetLocations.add(new PVector(lookatTarget.x, lookatTarget.y, lookatTarget.z));
  }

  void CycleTarget()
  {    
    count++;
    if (count >= targetLocations.size())
    {
      count = 0;
    }
  }

  PVector GetCurrentTarget()
  {
    PVector target = targetLocations.get(count);
    return target;
  }

  void Zoom (float pos)
  {
    radius = constrain(radius, 30, 200);
    radius += pos;
  }
};
