class Particle1
{
  PVector position;
  PVector gridPos;
  String ParticleName;
  color particleCol;
  boolean canMoveRight = true;
  boolean canMoveLeft = true;

  Particle1(int x, int y)
  {
    gridPos = new PVector(x, y);
    ParticleName = "Sand";
    particleCol = color(227, 208, 133);
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
    Particle2 waterBelow = new Particle2(width,height);
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
        waterBelow = waterParts.get(i); 
      }
    }
    if (canMoveDown && gridPos.y < rows-1)
    {
      gridPos.y +=1;
      hasMovedDown = true;
    }
    if (waterBelow.gridPos.x != width && waterBelow.gridPos.y != height)
    {
      waterBelow.gridPos.y = gridPos.y;
      gridPos.y += 1;
    }
    Particle2 waterRight = new Particle2(width,height);
    Particle2 waterLeft =  new Particle2(width,height);
    canMoveRight = true;
    canMoveLeft = true;
    for (int i = particles.size()-1; i >= 0; i--)
    {
      if (particles.get(i).gridPos.x - 1 == gridPos.x && particles.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveRight = false;
      }
      if (particles.get(i).gridPos.x + 1 == gridPos.x && particles.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveLeft = false;
      }
    }
    for (int i = waterParts.size()-1; i>= 0; i--)
    {
      if (waterParts.get(i).gridPos.x - 1 == gridPos.x && waterParts.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveRight = false;
        waterRight = waterParts.get(i);
      }
      if (waterParts.get(i).gridPos.x + 1 == gridPos.x && waterParts.get(i).gridPos.y - 1 == gridPos.y)
      {
        canMoveLeft = false;
        waterLeft = waterParts.get(i);
      }
    }
    if (!canMoveDown)
    {
      if (canMoveLeft || canMoveRight)
      {

        if (canMoveLeft && canMoveRight)
        {
          int k = round(random(0, 1));
          if (gridPos.y < rows-1 && k == 0 && !hasMovedSideways)
          {
            gridPos.x -= 1;
            gridPos.y += 1;
            hasMovedSideways = true;
          } else if (gridPos.y < rows-1 && k == 1 && !hasMovedSideways)
          {
            gridPos.x +=1;
            gridPos.y +=1;
            hasMovedSideways = true;
          }
        }
        if (canMoveLeft && gridPos.y < rows-1 && gridPos.x >= 0 && !hasMovedSideways)
        {
          gridPos.x -=1;
          gridPos.y +=1;
        } else if (canMoveRight && gridPos.y < rows-1 && gridPos.x < cols -1 && !hasMovedSideways)
        {
          gridPos.x +=1;
          gridPos.y +=1;
        }
      }
    }
    
    if (waterRight.gridPos.x != width)
    {
      PVector a = waterRight.gridPos.copy();
      
      waterRight.gridPos.y = gridPos.y;
      gridPos.x = a.x;
      gridPos.y = a.y;
    }
    if (waterLeft.gridPos.x != width)
    {
      PVector a = waterLeft.gridPos.copy();
      
      waterLeft.gridPos.y = gridPos.y;
      gridPos.x = a.x;
      gridPos.y = a.y;
    } 
    boolean isOverlapping = false;
    Particle2 overlapWater = new Particle2(width,height);
    for (int i = waterParts.size()-1; i>= 0; i--)
    {
      if (waterParts.get(i).gridPos.x == gridPos.x && waterParts.get(i).gridPos.y == gridPos.y)
      {
        isOverlapping = true;
        overlapWater = waterParts.get(i);
      }
    }
    if (isOverlapping && overlapWater.gridPos.x != width)
    {
      overlapWater.gridPos.y -=1;
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
