//art from https://www.kenney.nl/assets/pixel-vehicle-pack

//import the sound library
import processing.sound.*;

PImage fireTruck; //sprite to draw fire engine

//engine sounds for the fire truck
Pulse engine;
boolean engineOn = false; //is the engine running or not?

//siren sound
SawOsc siren;
boolean sirenOn = false; //is the siren on or not?

//timer to make the lights flash blue/red
float timer;
float maxTime = 10;
boolean redOn = false;

//buttons to turn on/off the engine and siren
Button ignition;
Button lights;

void setup() {
  size(400, 400);
  rectMode(CENTER);
  imageMode(CENTER);
  
  fireTruck = loadImage("firetruck.png"); //load the sprite

  //set up the buttons
  ignition = new Button(75, 350, 100, 50, "ignition");
  lights = new Button(325, 350, 100, 50, "siren");

  //call the constructor to initilise the pulse oscillator
  //set the amplitude (1, default, is very loud)
  //intial frequency of 0 is ok for the engine
  engine = new Pulse(this);
  engine.amp(0.15);

  //call the constructor to initilise the sine oscillator
  //set the amplitude (1, default, is very loud)
  //set the initial frequency
  siren = new SawOsc(this);
  siren.amp(0.1);
  siren.freq(550);
}

void draw() {
  background(255);
  text("Fire Truck Sim 9000", width/2, 100);
  
  //draw the sprite
  image(fireTruck, width/2, height/2, fireTruck.width * 3, fireTruck.height * 3);
  
  //draw the buttons
  ignition.display();
  lights.display();

  //if the engine is on, the pulse oscillator is playing,
  //set the frequency with mouse position, so mouse up revs the engine
  if (engineOn) {
    engine.freq(20 + map(mouseY, 100, 300, 30, 0) + random(-0.5, 0.5));
  }
  
  //draw the speedo/rev counter
  noStroke();
  fill(200);
  arc(200, 350, 120, 120, -PI, 0, CHORD);
  float theta;
  if (engineOn) {
    theta = map(mouseY, 000, 250, -PI/8, PI/4);
  } else {
    theta = map(400, 000, 250, -PI/8, PI/4);
  }
  float r = 50;
  float x = 200 - r * sin(theta);
  float y = 350 - r * cos(theta);
  strokeWeight(3);
  stroke(255, 0, 0);
  line(200, 350, x, y);

  //if the siren is on, the sine oscillator is playing
  //set the frequency to go up and down (using another sine wave...)
  if (sirenOn) {
    siren.freq(map(sin(frameCount/50.0), 0, 1, 550, 600));
    
    //a timer to flash the lights red/blue while the siren is on
    if (redOn) {
      noStroke();
      fill(255, 0, 0);
      rect(213, 165, 10, 10);
      fill(0, 0, 255);
      rect(233, 165, 10, 10);
    } else {
      noStroke();
      fill(0, 0, 255);
      rect(213, 165, 10, 10);
      fill(255, 0, 0);
      rect(233, 165, 10, 10);
    }
    timer++;
    if (timer > maxTime) {
      timer = 0;
      redOn = !redOn;
    }
  }
}

void mousePressed() {
  if (ignition.isMouseOver()) {
    if(engineOn){
      engineOn = false;
      engine.stop();
    } else {
      engineOn = true;
      engine.play();
    }
    ignition.isOn = engineOn;
  }

  if (lights.isMouseOver()) {
    if (sirenOn) {
      sirenOn = false;
      siren.stop();
    } else {
      sirenOn = true;
      timer = 0;
      siren.play();
    }
    lights.isOn = sirenOn;
  }
}
