float r1= 150;
float r2 =150;
float m1=20;
float m2=20;
float a1=PI/2;
float a2=PI/2;
float a1_v = 0;
float a2_v = 0;
float a1_a = 0;
float a2_a = 0;
float g=1;

float prev_x2 = 0;
float prev_y2 = 0;

PGraphics canvas;

void setup(){  
  
  //window size
  size(750,750);
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();

}

void draw(){  
  image(canvas,0,0);
  stroke(255);
  strokeWeight(2);
  
  translate(width/2, height/2.5);
  fill(0,178,169);
  
  //formula to calculate acceleration of first pendulum
  float numerator_1 = -g*(2*m1+m2)*sin(a1)-m2*g*sin(a1-2*a2)-2*sin(a1-a2)*m2*(a2_v*a2_v*r2 + a1_v*a1_v*r1*cos(a1-a2));
  float denomenator_1 = r1*(2*m1+m2-m2*cos(2*a1-2*a2));
  
  //formula to calculate acceleration of second pendulum
  float numerator_2 = 2*sin(a1-a2)*(a1_v*a1_v*r1*(m1+m2)+g*(m1+m2)*cos(a1)+a2_v*a2_v*r2*m2*cos(a1-a2));
  float denomenator_2 = r2*(2*m1+m2-m2*cos(2*a1-2*a2));
  
  a1_a= numerator_1/denomenator_1;
  a2_a= numerator_2/denomenator_2;
  
  //adding acceleration to velocity and assigning cordinates
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
  
  //descreasing velocity marginally everytime to create friction
  a1_v = a1_v*random(0.999, 1);
  a2_v = a2_v*random(0.999, 1);  
  
  //cordinates of first pendeulum
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  
  //cordinates of second pendeulum
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);  
  
  //rendering first pendulum
  line(0,0, x1, y1);   
  ellipse(x1, y1, m1, m1);
  
  //rendering second pendulum
  line(x1, y1, x2, y2); 
  ellipse(x2, y2, m2, m2);
  
  canvas.beginDraw();
  canvas.translate(width/2,height/2.5);
  canvas.strokeWeight(4);
  canvas.stroke(0,178,169, 100);
  if(frameCount>1)
    canvas.line(prev_x2,prev_y2, x2, y2);  
  canvas.endDraw(); 
  
  //saving previous cordinates
  prev_x2 = x2;
  prev_y2 = y2;

saveFrame("/output/double-pendulum-#####.png");
}
