/*
 * Using orientation data from Arduino to navigate a compass
 */

// Include libraries
 import apsync.*;
 import processing.serial.*;
 
//Sync variables
 public float ax;
 public float ay;
 public float az;
 
 //Make objects
 PFont oText;
 PShape panoramaSphere;
 PImage panoramaImage;
 
 //Declare variables
 float rotY;
 float xPos;
 
 //Create APsync variable to read from 
 AP_Sync readVals;   
 
 void setup()
 {
  //Set canvas size 
  size(1440,900, P3D);
  
  //Select serial port
  printArray(Serial.list());
  String serialPort = Serial.list()[2];
  readVals = new AP_Sync(this, serialPort, 9600);
  
  //Declare font attributes to display orientation data
  oText = createFont("Arial", 60);
  textFont(oText, 60);
  
  //Load images, Create objects
  panoramaImage = loadImage("panorama.jpg");
  lights();
  panoramaSphere = createShape(SPHERE, width/2);
  panoramaSphere.setStroke(false);
  panoramaSphere.setTexture(panoramaImage);
  noStroke();
   
 }
 
 void draw()
 {
   
   background(255);
   
   //Draw everything
   panoramaSphere();
   
   //panoramaFlat();
   //orientationData();

 }
 
 void panoramaSphere() 
 {
   
   //Map orientation data received from Arduino to rotation
   rotY = map(az/10, 0, width, 0, 200);
   translate(width/2, height/2, 0);
   rotateY(rotY);
   shape (panoramaSphere);
   
 }
 
 void panoramaFlat() 
 {
   
   //Map orientation data received from Arduino to position
   xPos = map(az*40, 0, width, 0, 200);
   imageMode(CENTER);
   image(panoramaImage, xPos, height/2);
   
 }
 
 void orientationData()
 {
   //Display orientation data received from Arduino
   textAlign(CENTER);
   text(ax+" : "+ay+" : "+az,width/2,700);
   fill (255,255,255);
 }
