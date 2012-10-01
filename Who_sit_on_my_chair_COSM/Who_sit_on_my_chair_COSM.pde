/*
Cosm Data Sender 

modified by yuta nakayama(didny@nus.edu.sg)
Originally Written by Tadokoro Atsushi
http://yoppa.org/tau_bmaw12/4010.html
https://docs.google.com/open?id=0BzyVHU69QO3mNTJLWThvSi15UDQ

edit by Cai Zhixiang, Lim Kim and Xinhao for pressure sensor on the foot of a chair
*/

import cosm.*;
DataOut feed;

import processing.serial.*;
Serial myPort;
float illumination = 0;
float sentData = 0;



String apiKey = "x0Y-iJabp_CvL4LNj43X46UJPt6SAKw1NVp1Q29sa0JSQT0g";
String feedId = "78125";

int currentTime;
int prevTime;
int sendInterval = 1000;

void setup() {
  size(400, 200);
  frameRate(20);
  noStroke();
  
  //for Windows
  String portName = "COM3"; //change this port the same name as Arduino->Tool->Serial Port
  //for Mac OSX
  //String portName = Serial.list()[0]; //the first port

  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
  feed = new DataOut(this, apiKey, feedId);
  feed.setVerbose(false);

}

void draw() {
  background(255);
  fill(0);
  text("Illumination = " + illumination, 10, 20);
  text("sent data = " + sentData, 10, 40);
  
  currentTime = millis();
  
  if((currentTime - prevTime) > sendInterval){
     sendVal();     
     prevTime = currentTime;
  }

}

void serialEvent(Serial p) {
  String inString0 = myPort.readStringUntil('\n');
  illumination = float(inString0);

}

void sendVal() {
  feed.setStream(0, illumination);
  sentData = illumination;
}

