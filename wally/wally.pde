//Variables Globals
var posx = 0;
var posy = 0;
var punts = 0;
var repinta = 1;
var tamany = 35;
var jugar = 1;

//Configurar pantalla
void setup(){
  size(800,600);
  background(0,0,0);
  cursor(CROSS);  
};

//Repintat de pantalla
draw = function(){
  if (jugar===1 && repinta===1){
    dibuixar_formes();
  }
};

void dibuixar_formes(){
  background(0,0,0);
  //Formes Despiste
  for(var i=0; i<=punts; i++){
    fill(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    ellipse(floor(random(50,750)),floor(random(100,550)),tamany,tamany);
  }
  //Forma Objectiu
  posx=floor(random(50,750));
  posy=floor(random(100,550))
  fill(255,0,0);
  ellipse(posx,posy,tamany,tamany);
  //Escriu puntuacio
  fill(255,0,0);
  textAlign(CENTER);
  textSize(18);
  text("Punts: " + (punts), 250, 30);
  //Escriu puntuacio
  fill(255,0,0);
  textAlign(LEFT);
  textSize(18);
  text("Temps: " + millis()/1000 , 20, 30);
  //Prepara nova pantalla
  repinta=0;
};

void mouseClicked(){
  if (jugar===1){
    if (repinta === 0) { repinta = 1;}
    if (mouseX>posx-tamany && mouseX<posx+tamany && mouseY>posy-tamany && mouseY<posy+tamany){
      punts+=1;
    }else{
      jugar=0;      
      //Escriu Game Over
      fill(255,0,0);
      textAlign(RIGHT);
      textSize(18);
      text("GAME OVER: " + punts + " en " +millis()/1000 + " segons ", 780, 30);
    }
  }
};




