//Configurar pantalla
void setup(){
  size(800,600);
  cursor(CROSS);  
}

//Repintat de pantalla
draw = function(){
  background(0,0,0);
  move_mouse();
  move_keyboard();
}

//Moure un objecte amb ratolí
move_mouse = function() {
  noStroke();
  fill(255,0,0);
  ellipse(mouseX,mouseY,25,25);
}

//Moure un objecte amb teclat
var keyX = 100;
var keyY = 100;
move_keyboard = function() {
  noStroke();
  fill(255,255,0);
  ellipse(keyX,keyY,25,25);
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP)    { keyY-=1; }
      if (keyCode == DOWN)  { keyY+=1; }
      if (keyCode == LEFT)  { keyX-=1; }
      if (keyCode == RIGHT) { keyX+=1; }
    }
  }
}