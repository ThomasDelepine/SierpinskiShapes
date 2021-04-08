int nbVertex = 3;
/*
Rules:
        1-Chose a point (by clicking in the shape, left button, one click)
        2-Chose a random vertex, different from the last one (the program does this, don't worry)<------^
        3-Draw a point at the middle of your point and your vertex (same)                               |
        4-Your point became the new point (same)                                                        |
        5-Back to 2-, to the infinity (same) ---------------------------------------------------------->|
        
Note: you can hide/show the polygon with the toggle variable : true to show, false to hide
      you can shose to see the Siepinski triangle or the form with 3 vertex following the rule with the boolean variable Sierpinski
*/
boolean toggle = false;  //show/hide the polygon
boolean sierpinski = true; //doesn't follow/follow all the rules. If true, so it won't follow all the rules, the Sierpinski Triangle will appear.
                           //Warning : for nbVertex == 4, it just fill the square
                           //foe exemple, for n == 5, the result is different in function of the value of the sierpinski variable, which is pretty cool
/*
1 : not interesting
2 : not interesting
3 : Sierpinski Triangle, the most interesting one (with sierpinski == true). Special rule for nbVertex = 3 : We can chose the same vertex two times in a raw.
4 : close frome the Sierpinski Carpet, but sadly, it's just close
5 : Scarabs (for sierpinski == false
6 : Snaw Flek
7 : The Monstre
...
11 : Donuts
...
...
...
99 : Donuts
*/


//constants :

float shapeSize = 1.5; 
int borne = 50;  //number of points per frame (basically the draw speed)
float radius = 400;  //circumscribed circle's radius, arbitrary chosen
float pointRadius = 1.5;  //radius of the points : the smaller => the more precise
PShape geometry;  //polygon drawn
boolean flag = true;  //for the beginning (pas encore implenté)$
float px = 0;
float py = 0;
color pointColor = #9D1EE3;
int nbPoint = 0;



int randVertex(int last){
    int r = int(random(nbVertex));
    while(r == last){
      r = int(random(nbVertex));
    }
    return r;
  }
  
PShape geometry(){
  PShape tmp = createShape();
  tmp.beginShape();
  tmp.noFill();
  tmp.stroke(pointColor);
  tmp.strokeWeight(shapeSize);
  for(int i = 0; i < nbVertex; i++){
      tmp.vertex(radius*cos(2*i*PI/nbVertex), radius*sin(2*i*PI/nbVertex));
  }
  tmp.vertex(radius, 0);
  tmp.endShape();
  return tmp;
}

void setup(){
  //size(500,500, P3D);
  size(1000, 800);

  frameRate(60);
  background(0x40);
  geometry = geometry();
}

void draw(){
  translate(width/2, height/2);
  rotate(PI/nbVertex);
  if(toggle) shape(geometry);
  //while(flag){}
  int last = -1;
  int r;
  
    //dessin
      for(int i = 0; i < borne; i++){
        r = randVertex(last);
        if(!sierpinski) last = r;
        px = (px + radius*cos(2*r*PI/nbVertex))/2;
        py = (py + radius*sin(2*r*PI/nbVertex))/2;
        noStroke();
        fill(pointColor);
        if(nbPoint > 100) 
            nbPoint++;
        else 
            circle(px, py, pointRadius);
      }
    
}

void mousePressed(){
  if(mouseButton == LEFT){
    if(flag){
      px = mouseX;
      py = mouseY;
      flag = false;
    }
  }
}
