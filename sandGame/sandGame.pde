ArrayList<Particle1> particles = new ArrayList<Particle1>();
ArrayList<Particle2> waterParts = new ArrayList<Particle2>();
boolean isMousePressed;
boolean rmbPressed = false;
boolean lmbPressed = false;
int gridScale = 8;

int cols, rows;

void setup()
{
  size(1400, 1000);

  //particles.add(new Particle1(0, 0));
  cols = width/gridScale;
  rows = height/gridScale;
  //frameRate(3);
}

void draw()
{
  //println(isMousePressed);
  isMousePressed = false;
  for (int i = 0; i < cols; i++)
  {
    for (int v = 0; v < rows; v++)
    {
      PVector pos = new PVector(i*gridScale, v*gridScale);
      //println(i,v);
      fill(#83D7FF, 45);
      //stroke(0);
      noStroke();
      rect(pos.x, pos.y, gridScale, gridScale);
    }
  }
  
  if (mousePressed)
  {
    if (mouseButton == LEFT)
    {
      lmbPressed = true;
    }
    if (mouseButton == RIGHT)
    {
      rmbPressed = true;
    }
    boolean canPlace = true;
    PVector newPos = findPosInGrid(mouseX, mouseY);

    for (int i = particles.size()-1; i >= 0; i--)
    {
      if (particles.get(i).gridPos.x == newPos.x && particles.get(i).gridPos.y == newPos.y)
      {
        canPlace = false;
      }
    }

    for (int i = waterParts.size()-1; i >= 0; i--)
    {
      if (waterParts.get(i).gridPos.x == newPos.x && waterParts.get(i).gridPos.y == newPos.y)
      {
        canPlace = false;
      }
    }

    if (canPlace && frameCount % 1 == 0)
    {
      if (lmbPressed)
      {
        particles.add(new Particle1((int)newPos.x, (int)newPos.y));
      }
      if (rmbPressed)
      {
        waterParts.add(new Particle2((int)newPos.x, (int)newPos.y));
      }
    }
  }

  for (int i = particles.size()-1; i >= 0; i--)
  {
    Particle1 thisPart = particles.get(i);

    thisPart.update();
    /**if (thisPart.gridPos.x == findPosInGrid(mouseX,mouseY).x && thisPart.gridPos.y == findPosInGrid(mouseX,mouseY).y)
     {
     fill(0);
     textAlign(CENTER,CENTER);
     println(thisPart.canMoveRight);
     text(" " + thisPart.canMoveRight,mouseX,mouseY - 30);
     text(" " + thisPart.canMoveLeft,mouseX,mouseY - 20);
     }**/
    //rect(thisPart.gridPos.x*gridScale, thisPart.gridPos.y*gridScale, gridScale, gridScale);
  }

  for (int i = waterParts.size()-1; i>= 0; i--)
  {
    Particle2 thisPart = waterParts.get(i);
    thisPart.update();
    /**
    if (thisPart.gridPos.x == findPosInGrid(mouseX,mouseY).x && thisPart.gridPos.y == findPosInGrid(mouseX,mouseY).y)
     {
     fill(0);
     textAlign(CENTER,CENTER);
     println(thisPart.canMoveRight);
     text(" " + thisPart.canMoveRight,mouseX,mouseY - 30);
     text(" " + thisPart.canMoveLeft,mouseX,mouseY - 20);
     }
     **/
  }
  fill(0);
  textSize(24);
  textAlign(LEFT,TOP);
  text("LMB for sand", 5,2);
  text("RMB for water", 5,20);
}

PVector findPosInGrid(int x, int y)
{
  PVector val;
  int valX = round(x/gridScale);
  int valY = round(y/gridScale);
  val = new PVector(valX, valY);
  return val;
}

void mouseReleased()
{
  lmbPressed = false;
  rmbPressed = false;
}

void mouseDragged()
{
  isMousePressed = true;
}
