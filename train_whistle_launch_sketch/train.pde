class Train {
  PVector position;
  PVector velocity;
  int direction;
  boolean drawSmoke = true;
  color col;

  Train(float y, float speed) {
    position = new PVector(0, y);
    velocity = new PVector(speed, 0);
    direction = 1;
    col = color(random(255), random(255), random(255));
  }
  

  void update() {
    //check if the train is at the edge of the screen, if so reverse train direction
    bounceOffScreenEdges();
    //increase train position in the direction we want
    moveTrain();
    //draw the train:
    drawTheTrain();
    //add smoke to the train, if the smoke is set to on
    if (drawSmoke == true) {
      drawTheSmoke();
    }
  }

  void moveTrain() {
    //trainPosition = trainPosition + trainSpeed;
    //position.x = position.x + velocity.x; //same code but using PVector
    position.add(velocity.mult(direction)); //doing it properly so the y values get included
  }

  void bounceOffScreenEdges() {
    //we're checking the right-hand-end of the train (trainPosition + width of the boiler)
    //at the right edge of the screen, and the left-and-end of the train (trainPosition)
    //at the left edge of the screen
    if ( (position.x + 50) >= width || position.x < 0) {
      direction = direction * -1;
    }
  }

  void drawTheTrain() {
    rectMode(CORNER);
    noStroke();
    fill(200);
    //the boiler
    rect(position.x, position.y + 20, 50, 20);
    rect(position.x + 35, position.y + 10, 10, 10);
    //the cab
    fill(col);
    rect(position.x, position.y, 20, 40);
  }

  void drawTheSmoke() {
    fill(75, 50);
    for (int i = 0; i < 5; i++) {
      //the loop draws 5 circles of smoke
      //each has a position slightly higher and behind the last
      //each has the phase of its sine function slightly offset from the last so they oscillate
      //in a "mexican wave" up the smoke trail, rather than all pulsing on/off at the same time
      ellipse(((position.x + 40) - (i * velocity.x)), position.y - 5 * i, 10 * sin((frameCount / 10) - (i / 2)) + 10, 10 * sin((frameCount / 10) - (i / 2)) + 10);
    }
  }

  void setSmoke() {
    //change makeSmoke from true to false or vice versa
    drawSmoke = !drawSmoke;
  }
}
