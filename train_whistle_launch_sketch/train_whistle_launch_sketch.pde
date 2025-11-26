//train whistle Sound Effect from <a href="https://pixabay.com/sound-effects/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=102834">Pixabay</a>

//import the sound library

Train train;

//declare a SoundFile


void setup() {
  size(400, 400);
  //load the sound effect from the data folder

  train = new Train(random(100, 300), random(0.5, 2));
}

void draw() {
  background(255);

  train.update();
}

void keyPressed(){
 //press space to toot the horn! But don't allow it to keep starting

}
