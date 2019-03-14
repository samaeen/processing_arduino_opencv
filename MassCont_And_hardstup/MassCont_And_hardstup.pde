import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

Capture video;
OpenCV opencv;

Serial port;
int num_of_faces;

void setup() {
  size(640, 480);
  //port = new Serial(this,"COM3",9600);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(60, 200, 100);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  num_of_faces=faces.length;
  println("number of faces: "+num_of_faces);
 println(faces.length);
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  if(num_of_faces == 1){
    println("There is one face");
   // port.write("a");
  }
  if(num_of_faces == 2)
  {
    println("there are two faces");
    //port.write("b");
  }
}

void captureEvent(Capture c) {
  c.read();
}