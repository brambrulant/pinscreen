PImage img;
float noise;
float xoff = 80;
float yoff = 0.01;
float zoff1 = 0;
float rotationX = 0;
float rotationY = 0;
 float tiles = 0;
 

void setup() {
  size(900, 900, P3D);
  frameRate(20);
  smooth();
  img = loadImage("UNADJUSTEDNONRAW_thumb_8f8.jpg");
  img.resize(900, 900);
}

void draw() {
  background(60,60,60);
  fill(255,105,180, 125);
  float tileSize = (width/tiles);

  xoff = xoff * 1;
  rotationY = rotationY + 5;
  rotationX = rotationX + 5;

  translate(width/2,height/2, -1000);
  
  if (rotationY <= 360) {
    rotateY(radians(rotationY));
    rotationX = 0;
    tiles = tiles + 0.7;
    } else {
      rotateX(radians(rotationX));
      tiles = tiles - 0.7;
        if (rotationX >= 360) {
          tiles = 0;
          rotationY = 0;
          //noLoop();   
          }
      }

  
  for (float x = 0; x < tiles; x++) {
    for (float y = 0; y < tiles; y++) {
      for (float z = 0; z < tiles; z=tiles) {
        color c = img.get(int(x*tileSize),int(y*tileSize));
        float b = map(brightness(c),0,255,0,1);
        float yoff = map(b,0,1,-10,10);
        float zoff = map(b,0,1,-50,50);

      
        push();
        float x1 = x*tileSize - width/2 ;
        float y1 = y*tileSize - height/2;
        float z1 = z*tileSize + zoff;
       stroke(b*255, 150, 150, b*255);
      translate(x1, y1, z1);
      //box(tileSize*b*0.4);
      //rotateX(rotation);
      beginShape();
      vertex(0, 0, 0);
      vertex(0,yoff,0);
      vertex(yoff,yoff,0);
      vertex(yoff,0,0);
      vertex(0, 0, zoff);
      vertex(0,yoff,zoff);
      vertex(yoff,yoff,zoff);
      vertex(yoff,0,zoff);
      endShape();
      pop();
     
      
      
      }
    }
  }
  //saveFrame("psweb-######.png");
}
