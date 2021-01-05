/* @pjs preload="arkanoidship.gif"; */

// Global variables        
var tamx = 640;
var tamy = 480;
var vidas = 3;
var puntos = 0;
var jugar = 1;
var tamx_targets=50;
var tamy_targets=20;
var x;
var y;
var inicio;

//Array de targets
int[][] disparos = { {} };
int[][][] targets = { 
  {100,50,1}, {200,50,1}, {300,50,1}, {400,50,1}, 
  {100,100,1}, {200,100,1}, {300,100,1}, {400,100,1} ,
  {100,150,1}, {200,150,1}, {300,150,1}, {400,150,1} 
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
  inicio = 0;
}

void draw(){
  
  if (jugar == 1){
    pintar_fondo();
    pintar_targets();
    pintar_disparos();
    pintar_nave();
  }
control_vidas();
}

void pintar_disparos(){
  for (int i = 0; i < disparos.length; i = i+1) {
    disparos[i][1]-=5;	
    noStroke();
    fill(255,0,0);
    ellipse(disparos[i][0],disparos[i][1],5,5);
    //Eliminar disparos que llegan  arriba
    if (disparos[i][1] < 40 ) {
      disparos = concat( subset(disparos,0,i) , subset(disparos,i+1,disparos.length-i) );
      puntos-=100;
      if (puntos<=0){puntos=0;}
      }else{
      //Colision
      colision(i);
    }

  }
}

void colision(bala){ 
    var contacto=0;
    var tempx=0;
    var tempy=0;
    var i=0;
    while(contacto==0 && i<targets.length){
      tempx=targets[i][0];
      tempy=targets[i][1];
      if ( (disparos[bala][0] <= tempx + tamx_targets && disparos[bala][0] >= tempx ) && ( disparos[bala][1] >= tempy && disparos[bala][1] <= tempy + tamy_targets) ){
        contacto=1;
        puntos += targets[i][1];
	var sound = new Howl({urls: ['pop.wav']}).play();
	//Quitar target contactado	
	targets = concat( subset(targets,0,i) , subset(targets,i+1,targets.length-i) );
	//Quitar bala
	disparos = concat( subset(disparos,0,bala) , subset(disparos,bala+1,disparos.length-bala) );
      }
    i+=1;
    }
}

void genera_disparo(){
  if (disparos.length <= 3 ){
    disparos = append(disparos, {mouseX+15,tamy-40});	
    var sound = new Howl({urls: ['blip.wav']}).play();
  }
}

void pintar_targets(){
  for (int i = 0; i < targets.length; i = i+1) {
    stroke(255);
    fill(targets[i][0],targets[i][1],0);
    rect(targets[i][0],targets[i][1],tamx_targets,tamy_targets);
    //Movimiento de las naves    
    if (targets[i][0] > (tamx - 50) && targets[i][2] == 1){
      targets[i][2]= -1;
      targets[i][1]+=25;
    }
    if (targets[i][0] < 50 && targets[i][2] == -1){
      targets[i][2]= 1;
      targets[i][1]+=25;
    }
    targets[i][0]+=targets[i][2];
    //Game Over
    if (targets[i][1] >= (tamy - 100) ){
      vidas-=1; 
      //Quitar target contactado	
      targets = concat( subset(targets,0,i) , subset(targets,i+1,targets.length-i) );
    }
  }
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
  if (inicio !=0){
    x = mouseX;
    if (x > tamx - 40){x = tamx - 40;}
  }else{
    x = mouseX;
    ballx = mouseX + 15;
  }
}

void mouseClicked() {
  if (inicio == 0){
    inicio = 1;  
  }else{
    genera_disparo();
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

  if (targets.length == 0){
    jugar = 0;
    fill(255,255,255);
    textSize(45);
    textAlign(CENTER);
    text("SUCCESS!", tamx / 2, tamy / 2);
  }

  fill(255,0,0);
  textAlign(LEFT);
  textSize(18);
  text("LIFES: " + vidas, 50, 30);

  textAlign(CENTER);
  textSize(18);
  text("TARGETS: " + targets.length, tamx /2, 30);

  textAlign(RIGHT);
  textSize(18);
  text("POINTS: " + puntos, tamx - 50, 30);
}
