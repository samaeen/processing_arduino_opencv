import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;
import cc.arduino.*;

Capture video;
Arduino arduino;
OpenCV opencv;
int num_of_faces;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  for (int i = 0; i <= 15; i++)
    arduino.pinMode(i, Arduino.INPUT);
    
  arduino.pinMode(13,Arduino.OUTPUT);
}
void draw() {
  int sensorValue=arduino.analogRead(8);
  Rectangle[] faces = opencv.detect();
  num_of_faces=faces.length;
  scale(2);
  println(sensorValue);
  println(num_of_faces);
  if(sensorValue>500){
  video.start();
  opencv.loadImage(video);
  image(video, 0, 0 );
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  }
  saveFrame("frames/####.png");

}
void captureEvent(Capture c) {
  c.read();
}