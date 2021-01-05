// Global variables        
var tamx = 640;
var tamy = 480;
var ballx=tamx/2;
var bally=tamy-50;
var balltam=10;
var ballvel=5;
var dirx=1;
var diry=-1;

// Setup Processing Canvas
void setup() {
  size(tamx, tamy);
  background(0,0,0);
  cursor(CROSS);
}

void draw(){
  rebot();
}

void rebot(){
  //Pintar fondo
  background(0,0,0);
  //Pintar bola
  fill(255,255,255);
  ellipse(ballx, bally, balltam, balltam);
  //Moviment de la bola
  if (dirx > 0){ballx+=ballvel;}else{ballx-=ballvel;}
  if (diry > 0){bally+=ballvel;}else{bally-=ballvel;}
  //Rebots del borde de pantalla
  if (ballx >= tamx){ dirx=-1; }
  if (ballx <= 0){ dirx=1; }
  if (bally >= tamy){ diry=-1;}
  if (bally <= 0){diry=1; }
}

void mouseClicked(){
  ballx = random(50,tamx-50);
  bally = random(50,tamy-50);
}
