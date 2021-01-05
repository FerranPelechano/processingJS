// Global variables        
var tamx = 640;
var tamy = 480;
var semaforo=150;
var monedes=3;
var x=0;
var y=0;
var z=0;
var missatge="";

// Setup Processing Canvas
void setup() {
  size(tamx, tamy);
  background(0,0,0);
  cursor(CROSS);
}

void draw(){
  if (semaforo>0){
    //Pintar fondo
    background(0,0,0);
    //Generar nou valors
    if (semaforo>100){x=floor(random(0,10));}
    if (semaforo>50) {y=floor(random(0,10));}
    if (semaforo>0)  {z=floor(random(0,10));}
    //Dibuixar iconos    
    noStroke();
    fill(255,255,255);
    rect(tamx/4 - 25,tamy/2 - 50, 50,100);
    rect(2*tamx/4 - 25,tamy/2 - 50, 50,100);
    rect(3*tamx/4 - 25,tamy/2 - 50, 50,100);
    fill(255,0,0);
    textSize(40);
    text(x,tamx/4,tamy/2) ;
    text(y,tamx/2,tamy/2) ;
    text(z,3*tamx/4,tamy/2) ;
    //Comprovar si tens premi
    if (semaforo==1){
      if (x==y && y==z){ 
        monedes+=50;
        missatge="¡Tres iguals! Has guanyat 50 monedes";
      }else if (x==y || x==z || y==z){ 
        monedes+=5;
        missatge="¡Dos iguals! Has guanyat 5 monedes";
      }else{
        missatge="Sense premi!";
      }    
    }
    //Dibuixa monedes
    fill(255,0,0);
    textSize(45);
    textAlign(CENTER);
    text("MONEDES: "+monedes, tamx / 2, 50);
    textSize(20);
    text(missatge, tamx / 2, tamy - 50);
    //Decrementar semaforo  
    semaforo-=1;
  }  
}

void mouseClicked() {
  if (monedes>0){
    semaforo=150;
    monedes-=1;
    missatge="";
  }
}


