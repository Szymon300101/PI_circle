String[] lines;
float arc=0.5; //"curveness" factor
int shift=2; //gap between parts
int dim=7; //gradient inside of part


void setup()
{
  
  //loading PI from file to string
  lines = loadStrings("pi.txt");
  size(650,650);
  background(0);
  colorMode(HSB,360);
  noFill();
  paint2();
}

void draw()
{ 
  //empty draw, so keyPressed() can be processed
}

//processing keyes pressed
void keyPressed()
{
  println(keyCode);
  switch(keyCode)
  {
    case 38: arc+=0.02; break; //^
    case 40: arc-=0.02; break; //v
    case 39: shift+=1; break; //-->
    case 37: if(shift>0) shift-=1; break; //<--
    case 44: dim+=1; break; //<
    case 46: if(dim>0)dim-=1; break; //>
    case 32: saveFrame(); break; //SPACE
    
  }
  //reloading image after changing settings
  paint2();
}

//function creating image
void paint2()
{
  background(0);
  strokeWeight(0.2);
  translate(width/2,height/2);
  float r=height/2-20;
  float angle=radians(108);  //angular position of '3' part as current part
  float delta;
  //draws line for 3000 digits of PI
  for(int i=0;i<3000;i++)
  {
    delta=radians(random(0,36-shift)); //chooses random place in current part of circle
    rotate(angle+delta);
    //finds the first point, and anchors for Benzier curve 
    int x=int(screenX(0,r))-width/2;
    int y=int(screenY(0,r))-height/2;
    int ax=int(screenX(0,r*arc))-width/2;
    int ay=int(screenY(0,r*arc))-height/2;
    rotate(-(angle+delta));
    int val = int(lines[0].charAt(i))-'0'; //gets new digit from string
    stroke(val*36,360,360-(dim*degrees(delta)));
    angle=radians(val*36); //sets new part
    rotate(angle+delta);
    //finds the second point, and anchors for Benzier curve 
    int a=int(screenX(0,r))-width/2;
    int b=int(screenY(0,r))-height/2;
    int aa=int(screenX(0,r*arc))-width/2;
    int ab=int(screenY(0,r*arc))-height/2;
    rotate(-(angle+delta));
    bezier(x,y,ax,ay,aa,ab,a,b); //paints a curve
  }
  
}
