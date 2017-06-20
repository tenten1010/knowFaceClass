import processing.serial.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
  

Capture video;
OpenCV opencv;
Detector detector;
//Serial serial;
static float[][] sample= new float[10][3];
float[][] order = {{0,0},{0,0},{0,0}};
int num=0;
int isFace=0;

void setup() {
  size(640, 480);
  fill(255,10,50);
  textSize(10);  
  textAlign(CENTER);  
  String[] cameras = Capture.list();
  //println(cameras[1]);
  //video = new Capture(this, 640/2, 480/2, "Logitech Camera");
  //video = new Capture(this, 640/2, 480/2);
  video = new Capture(this, 640/2, 480/2, cameras[0]);
  opencv = new OpenCV(this, 640/2, 480/2);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  detector = new Detector();
  //serial = new Serial(this,"/dev/cu.usbmodem1441",9600);
  
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );
  
  if(num == 0){
    text("Put object in front of camera to make computer learn", width/5, height/2);  
  }
  if(num == 10){
    delay(1);
    text("Recognize start", width/5, height/2);
  }
  filter(THRESHOLD);
  //filter(GRAY);
  //filter(INVERT);
  //filter(ERODE);
  //filter(POSTERIZE, 4);
}

void mousePressed(){
  noFill();
  strokeWeight(1);  
  detector.update(OpenCV.CASCADE_FRONTALFACE, 0, 255, 0,num);
  //detector.update(OpenCV.CASCADE_MOUTH,2, 255, 0, 255);
  if(isFace==0){
    num ++;
  }else{
    num = num;
  }
}

void captureEvent(Capture c) {
  c.read();
}