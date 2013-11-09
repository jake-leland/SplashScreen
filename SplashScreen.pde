// Jake Leland

/*
 * This is a visual program indended to replicate the splash screen
 * of Processing 1.*
 *
 * There is no need to change anything in this code,
 * The keyboard can be used to dynamically change the values.
 *
 * Click to create a LinkedCircle.
 * Press space to bump the circles up off the ground
 * (if they are resting on the ground).
 */

ArrayList<LinkedCircle> circles = new ArrayList<LinkedCircle>();
int circleD = 50;
int variance = 25;
int tol = 100;
int bumpStrength = 50;
String toString;
int fontSize;
boolean paused = false;

void setup()
{
  updateToString();
  size(800,600);
  smooth();
  println(toString);
  fontSize = 15;
}

void draw()
{
  updateToString();
  background(0);
  for(LinkedCircle c1 : circles)
  {
    c1.d();
    for(LinkedCircle c2 : circles)
    {
      stroke(255);
      if(dist(c1.getX(),c1.getY(),c2.getX(),c2.getY()) <= tol)
        line(c1.getX(),c1.getY(),c2.getX(),c2.getY());
    }
  }
  fill(255);
  textSize(fontSize);
  text(toString,5,fontSize);
}

void mouseWheel(int delta)
{
  //tol -= delta*10;
  //println(tol);
}

void mouseReleased()
{
  int plusMinus = round(circleD*(variance/100.0));
  circles.add(new LinkedCircle(mouseX,mouseY,round(random(circleD-plusMinus,circleD+plusMinus))));
}

void keyPressed()
{
  if(key == ' ')
  {
    println("Bump!");
    for(LinkedCircle c1 : circles)
    {
      c1.bump();
    }
  }
  else if(key == 'a')
  {
    if(circleD<min(width,height)/2)
      circleD += 5;
  }
  else if(key == 'z')
  {
    if(circleD>0)
      circleD -= 5;
  }
  else if(key == 's')
  {
    if(variance<100)
    {
      variance += 5;
    }
  }
  else if(key == 'x')
  {
    if(variance>0)
    {
      variance -= 5;
    }
  }
  else if(key == 'd')
  {
    if(tol<sqrt(sq(width)+sq(height)))
      tol += 5;
  }
  else if(key == 'c')
  {
    if(tol>0)
      tol -= 5;
  }
  else if(key == 'f')
  {
    if(bumpStrength<height/6)
      bumpStrength += 5;
  }
  else if(key == 'v')
  {
    if(bumpStrength>0)
      bumpStrength -= 5;
  }
  else if(key == 'q')
  {
    println("Cleared all circles.");
    circles.clear();
  }
  else if(key == 'r')
  {
    println("Reset to default values.");
    circleD = 50;
    variance = 25;
    tol = 100;
    bumpStrength = 50;
  }
  else if(key == 'p')
  {
    if(paused)
    {
      println("Un-Paused.");
      for(LinkedCircle c1 : circles)
        c1.unpause();
    }
    else
    {
      println("Paused.");
      for(LinkedCircle c1 : circles)
        c1.pause();
    }
    paused = !paused;
  }
  else
  {
    println("That key doesn't do anything...");
  }
  println(toString);
}

void updateToString()
{
  toString = "Size [a/z]: " + circleD + "px  ||  Variance [s/x]: " + variance + "%  ||  Line Length [d/c]: " + tol + "px  ||  Avg Bump Strength [f/v]: " + bumpStrength + "px";
}
