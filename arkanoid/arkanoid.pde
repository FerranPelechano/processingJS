/* @pjs preload="arkanoidship.gif"; */

// Global variables        
var tamx = 640;
var tamy = 480;
var vidas = 3;
var rebotes = 0;
var jugar = 1;
var tamx_bloques=50;
var tamy_bloques=20;
var x;
var y;
var ballx;
var bally;
var balltam;
var ballvel;
var dirx;
var diry;
var inicio;

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
  iniciar();
}

void iniciar(){
  x = tamx / 2;
  y = tamy - 50;
  ballx = x + 15;
  bally = y + 4;
  balltam = 10;
  ballvel = 5;
  dirx = 1;
  diry = -1;
  inicio = 0;
}

void draw(){
  if (jugar == 1){
    pintar_fondo();
    pintar_bloques();
    control_vidas();
    pintar_nave();
    pintar_bola();
    rebote();
  }
}

void pintar_bloques(){
  for (int i = 0; i < bloques.length; i = i+1) {
    stroke(255);
    fill(bloques[i][0],bloques[i][1],0);
    rect(bloques[i][0],bloques[i][1],tamx_bloques,tamy_bloques);
  }
}

void pintar_fondo(){
  background(0,0,0);
  fill(255,0,0);
  rect(0,tamy-10,tamx,tamy);
}


void pintar_bola(){
  fill(255,255,255);
  ellipse(ballx, bally, balltam, balltam);
}

void pintar_nave(){
  PImage im = loadImage("arkanoidship.gif");
  image(im, x, y);
}

void mouseMoved(){
  if (inicio !=0){
    x = mouseX;
    if (x > tamx - 40){x = tamx - 40;}
  }else{
    x = mouseX;
    ballx = mouseX + 15;
  }
}

void mouseClicked() {
  inicio = 1;  
}

void rebote(){
  if (inicio != 0){
    //Movimiento de la bola
    if (dirx > 0){ballx+=ballvel;}else{ballx-=ballvel;}
    if (diry > 0){bally+=ballvel;}else{bally-=ballvel;}
    //Rebotes de borde de pantalla
    if (ballx >= tamx){
		dirx=-1;
		var sound = new Howl({urls: ['blip.wav']}).play(); 
	}
    if (ballx <= 0){
		dirx=1; 
		var sound = new Howl({urls: ['blip.wav']}).play();
	}
    if (bally >= tamy){	
		var sound = new Howl({urls: ['ah.wav']}).play();
		vidas-=1;
		iniciar();	
	}
    if (bally <= 0){
		diry=1; 
		var sound = new Howl({urls: ['blip.wav']}).play();
	}
    //Toca la barra
    if ( (ballx <= x + 50 && ballx >= x - 50 ) && ( bally >= y - ( ballvel / 2 ) - 1 && bally <= y + ( ballvel / 2 ) + 1) ){diry=-1; rebotes+=1;} 
    //println("Rebote: " + ballx + "=" + x );

    //Toca un bloque
    contacto=0;
    var i=0;
    var tempx=0;
    var tempy=0;
    while(contacto==0 && i<bloques.length){
      tempx=bloques[i][0];
      tempy=bloques[i][1];
      if ( (ballx <= tempx + tamx_bloques && ballx >= tempx ) && ( bally >= tempy && bally <= tempy + tamy_bloques) ){
		contacto=1;
		var sound = new Howl({urls: ['pop.wav']}).play();
		//Quitar bloque contactado	
		bloques = concat( subset(bloques,0,i) , subset(bloques,i+1,bloques.length-i) );
        //dirx=dirx * (-1);
        diry=diry * (-1);
      } 
      i+=1;
    }


  }
}

void control_vidas(){
  if (vidas == 0){
    jugar = 0;
    fill(255,255,255);
    textSize(45);
    textAlign(CENTER);
    text("GAME OVER", tamx / 2, tamy / 2);
  }

  if (bloques.length == 0){
    jugar = 0;
    fill(255,255,255);
    textSize(45);
    textAlign(CENTER);
    text("SUCCESS!", tamx / 2, tamy / 2);
  }

  fill(255,0,0);
  textAlign(LEFT);
  textSize(18);
  text("BALLS: " + vidas, 50, 30);

  textAlign(CENTER);
  textSize(18);
  text("BLOCKS: " + bloques.length, tamx /2, 30);

  textAlign(RIGHT);
  textSize(18);
  text("POINTS: " + rebotes, tamx - 50, 30);
}
