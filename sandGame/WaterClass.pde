class Particle2
{
  PVector position;
  PVector gridPos;
  String ParticleName;
  color particleCol;
  boolean canMoveRight = true;
  boolean canMoveLeft = true;

  Particle2(int x, int y)
  {
    gridPos = new PVector(x, y);
    ParticleName = "Water" + frameCount;
    particleCol = color(56, 10, 245);
  }

  void update()
  {
    move();
    //test();
    draw();
  }

  void move()
  {

    boolean canMoveDown = true;
    boolean hasMovedDown = false;
    boolean hasMovedSideways = false;
    canMoveRight = true;
    canMoveLeft = true;
    for (int i = particles.size()-1; i >= 0; i--)
    {
      if (particles.get(i).gridPos.x - 1 == gridPos.x && particles.get(i).gridPos.y == gridPos.y)
      {
        canMoveRight = false;
      }
      if (particles.get(i).gridPos.x + 1 == gridPos.x && particles.get(i).gridPos.y == gridPos.y)
      {
        canMoveLeft = false;
      }
    }
    for (int i = waterParts.size()-1; i>= 0; i--)
    {
      if (waterParts.get(i).gridPos.x - 1 == gridPos.x && waterParts.get(i).gridPos.y == gridPos.y)
      {
        canMoveRight = false;
      }
      if (waterParts.get(i).gridPos.x + 1 == gridPos.x && waterParts.get(i).gridPos.y == gridPos.y)
      {
        canMoveLeft = false;
      }
    }
    if (canMoveLeft || canMoveRight)
    {

      if (canMoveLeft && canMoveRight)
      {
        int k = round(random(0, 1));
        if (gridPos.x > 0 && k == 0 && !hasMovedSideways)
        {
          gridPos.x -= 1;

          hasMovedSideways = true;
        } else if (gridPos.x < cols-1 && k == 1 && !hasMovedSideways)
        {
          gridPos.x +=1;

          hasMovedSideways = true;
        }
      }
      if (canMoveLeft && gridPos.y < rows-1 && gridPos.x >= 0 && !hasMovedSideways)
      {
        gridPos.x -=1;
      } else if (canMoveRight && gridPos.y < rows-1 && gridPos.x < cols -1 && !hasMovedSideways)
      {
        gridPos.x +=1;
      }
    }

    for (int i = particles.size()-1; i >= 0; i--)
    {
      if (particles.get(i).gridPos.x == gridPos.x && particles.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveDown = false;
      }
    }
    for (int i = waterParts.size()-1; i>= 0; i--)
    {
      if (waterParts.get(i).gridPos.x == gridPos.x && waterParts.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveDown = false;
      }
    }
    if (canMoveDown && gridPos.y < rows-1)
    {
      gridPos.y +=1;
      hasMovedDown = true;
    }
    boolean isOverlapping = false;
    for (int i = waterParts.size()-1; i>= 0; i--)
    {
      if (waterParts.get(i).gridPos.x == gridPos.x && waterParts.get(i).gridPos.y == gridPos.y && !ParticleName.equals(waterParts.get(i).ParticleName))
      {
        isOverlapping = true;
      }
    }
    
    if (isOverlapping)
    {
      gridPos.y -=1;
    }
  }

  void draw()
  {
    fill(particleCol);
    noStroke();
    rect(gridPos.x*gridScale, gridPos.y*gridScale, gridScale, gridScale);
  }

  void test()
  {
    for (int i = particles.size()-1; i >= 0; i--)
    {
      if (particles.get(i).gridPos.x - 1 == gridPos.x && particles.get(i).gridPos.y - 1 == gridPos.y)
      {
        particles.get(i).particleCol = color(0, 255, 0);
      }
      if (particles.get(i).gridPos.x + 1 == gridPos.x && particles.get(i).gridPos.y - 1 == gridPos.y)
      {
        particles.get(i).particleCol = color(255, 0, 0);
      }
    }
  }
}
