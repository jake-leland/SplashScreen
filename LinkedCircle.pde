class LinkedCircle
{
  int d;
  int x;
  int y0;
  int y;
  float t0;
  float vi;
  float vf;
  int timeStopped;
  boolean stopped;
  float vStore;
  int m;
  
  LinkedCircle(int x, int y0, int d)
  {
    this.x = x;
    this.y0 = y0;
    this.d = d;
    vi = 0;
    t0 = millis();
    stopped = false;
    m = millis();
  }
  
  void bump()
  {
    if(stopped && !paused)
    {
      stopped = false;
      vi = random(1*bumpStrength,2*bumpStrength);
      t0 = millis();
    }
  }
  
  void d()
  {
    if(abs(vi) < 1 && abs(vf) < 1 && !paused)
      timeStopped++;
    else
      timeStopped = 0;
    if(timeStopped > 3)
      stopped = true;
    if(!paused)
      m = millis();
    if(!stopped)
    {
      float t = (m-t0)/1000.0;
      t *= 10;
      vf = vi + (-9.8 * t);
      float dist = ((vi+vf)/2) * t;
      y = round(y0 - dist);
      if(y+round(d/2.0) >= height)
      {
        vi = -vf -((-vf)/5);
        t0 = millis();
        y0 = height-(d/2);
      }
    }
    else
    {
      y = height-round(d/2.0);
    }
    noStroke();
    fill(0,50,100,100);
    ellipse(x,y,d,d);
  }
  
  void pause()
  {
    vStore = vf;
  }

  void unpause()
  {
      vi = vStore;
      t0 = millis();
      y0 = y;
  }
  
  int getX()
  {
    return x;
  }
  
  int getY()
  {
    return y;
  }
}
