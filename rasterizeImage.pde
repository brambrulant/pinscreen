PImage img;
float noise;
float xoff = 0;
float yoff = 0;
float zoff1 = 0;
float rotationX = 0;
float rotationY = 0;
float pins = 0; // initial number of pins
 

void setup() {
  size(900, 900, P3D);
  frameRate(20);
  smooth();
  img = loadImage(""); // add your image here, also make sure to add it to the data folder by dragging the image into the editor window. 
  img.resize(900, 900);
}

void draw() {
  background(60,60,60);
  fill(255,105,180, 125);
  float pinSize = (width/pins);

  rotationY = rotationY + 5;
  rotationX = rotationX + 5;

  translate(width/2,height/2, -1000);
  
  
  // this is a perfect loop. when the y rotation is fully 360 degrees, the y rotation stops and the x rotation starts. the number of pins also increases and decreases.
  
  if (rotationY <= 360) {
    rotateY(radians(rotationY));
    rotationX = 0;
    pins = pins + 0.7;
    } else {
      rotateX(radians(rotationX));
      pins = pins - 0.7;
        if (rotationX >= 360) {
          pins = 0;
          rotationY = 0;
          //noLoop();   
          }
      }

  // here we're making the grid in x & y. The z loop is for the layers. 
  
  for (float x = 0; x < pins; x++) {
    for (float y = 0; y < pins; y++) {
      for (float z = 0; z < pins; z+=10) {
        color c = img.get(int(x*pinSize),int(y*pinSize));
        float b = map(brightness(c),0,255,0,1);
        float xoff = map(b,0,1,-10,10);
        float yoff = map(b,0,1,-10,10);
        float zoff = map(b,0,1,-50,50);

        push();
        
        stroke(b*255, 150, 150, b*255);

        float x1 = x*pinSize - width/2 ;
        float y1 = y*pinSize - height/2;
        float z1 = z*pinSize + zoff;
        
        translate(x1, y1, z1);
        
        beginShape();
        vertex(0, 0, 0);
        vertex(0,yoff,0);
        vertex(xoff,yoff,0);
        vertex(xoff,0,0);
        vertex(0, 0, zoff);
        vertex(0,yoff,zoff);
        vertex(xoff,yoff,zoff);
        vertex(xoff,0,zoff);
        endShape();
        
        pop();
     
      
      
      }
    }
  }
  //saveFrame("pinart-######.png"); // uncomment if you wanna save every frame as a png. 
}
