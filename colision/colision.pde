// Global variables        
var tamx = 640;
var tamy = 480;
var ballx=tamx/2;
var bally=tamy-50;
var balltam=10;
var ballvel=5;
var dirx=1;
var diry=-1;
var tamx_bloques=50;
var tamy_bloques=20;

//Array de bloques
int[][] bloques = { 
  {50, 50}, {100,50}, {150,50}, {200,50}, {250,50}, {300,50}, {350,50}, {400,50}, {450,50}, {500,50}, {550,50},
  {50, 75}, {100,75}, {150,75}, {200,75}, {250,75}, {300,75}, {350,75}, {400,75}, {450,75}, {500,75}, {550,75},
  {50, 100}, {100,100}, {150,100}, {200,100}, {250,100}, {300,100}, {350,100}, {400,100}, {450,100}, {500,100}, {550,100},
  {50, 125}, {100,125}, {150,125}, {200,125}, {250,125}, {300,125}, {350,125}, {400,125}, {450,125}, {500,125}, {550,125},
  {50, 150}, {100,150}, {150,150}, {200,150}, {250,150}, {300,150}, {350,150}, {400,150}, {450,150}, {500,150}, {550,150}
};

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
  //Pintar obstacles
  for (int i = 0; i < bloques.length; i = i+1) {
    stroke(255);
    fill(bloques[i][0],bloques[i][1],0);
    rect(bloques[i][0],bloques[i][1],tamx_bloques,tamy_bloques);
  }
  //Pintar bola
  fill(255,255,255);
  ellipse(ballx, bally, balltam, balltam);
  //Moviment de la bola
  if (dirx > 0){ballx+=ballvel;}else{ballx-=ballvel;}
  if (diry > 0){bally+=ballvel;}else{bally-=ballvel;}
  //Col·lisió amb objecte
  contacto=0;
  var i=0;
  var tempx=0;
  var tempy=0;
  while(contacto==0 && i<bloques.length){
    tempx=bloques[i][0];
    tempy=bloques[i][1];
    if ( (ballx <= tempx + tamx_bloques && ballx >= tempx ) && ( bally >= tempy && bally <= tempy + tamy_bloques) ){
      contacto=1;
      //Llevar obstacle
      bloques = concat( subset(bloques,0,i) , subset(bloques,i+1,bloques.length-i) );
      diry=diry * (-1);
    } 
    i+=1;
  }
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


