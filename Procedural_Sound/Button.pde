class Button {
 PVector position;
 PVector size;
 String label;
 boolean isOn;
 
 Button(int x, int y, int w, int h, String l){
  position = new PVector(x, y); 
  size = new PVector(w, h);
  label = l;
  isOn = false;
 }
 
 void display(){
   rectMode(CENTER);
   if(isMouseOver() == true) {
     if(mousePressed) {
       //mouse is over the button and down, draw super-bright
       fill(225);
     } else {
       //mouse is over the button but not down, show rollover highlight
       fill(200);
     }
   } else {
     //mouse is not over the button, grey colour
     fill(150);
   }
   if(isOn){
     stroke(0);
   } else {
     noStroke();
   }
   
   rect(position.x, position.y, size.x, size.y);
   
   textAlign(CENTER);
   textSize(24);
   fill(0);
   text(label, position.x, position.y + 12);
 }
 
 boolean isMouseOver(){
  return (mouseX > position.x -  size.x /2 && mouseX < position.x + size.x/2 && mouseY > position.y -  size.y /2 && mouseY < position.y + size.y/2);
 }
}
