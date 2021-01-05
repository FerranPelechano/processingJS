/* @pjs preload="arkanoidship.gif"; */

// Global variables        
var tamx = 640;
var tamy = 480;
var x=tamx / 2;
var y=tamy - 50;
int[][] disparos = { {} };

// Setup Processing Canvas
void setup() {
  size(tamx, tamy);
  background(0,0,0);
  cursor(CROSS);
}

void draw(){
  pintar_fondo();
  pintar_nave();
  pintar_disparos();
}

void pintar_fondo(){
  background(0,0,0);
  fill(255,0,0);
  rect(0,tamy-10,tamx,tamy);
}

void pintar_nave(){
  PImage im = loadImage("arkanoidship.gif");
  image(im, x, y);
}

void mouseMoved(){
  x = mouseX;
  if (x > tamx - 40){x = tamx - 40;}
}

void mouseClicked() {
    genera_disparo();
}

void pintar_disparos(){
  for (int i = 0; i < disparos.length; i = i+1) {
    disparos[i][1]-=5;	
    noStroke();
    fill(255,0,0);
    ellipse(disparos[i][0],disparos[i][1],5,5);
     if (disparos[i][1] < 40 ) {
      disparos = concat( subset(disparos,0,i) , subset(disparos,i+1,disparos.length-i) );
    }
  }
}

void genera_disparo(){
  if (disparos.length <= 3 ){
    disparos = append(disparos, {mouseX+15,tamy-40});	
    var sound = new Howl({urls: ['blip.wav']}).play();
  }
}
