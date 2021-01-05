//Variables Globals
var repinta = 1;
var tamany = 35;

//Configurar pantalla
void setup(){
  size(800,600);
  background(0,0,0);
  cursor(CROSS);  
};

//Repintat de pantalla
draw = function(){
  if (repinta===1){ dibuixar_formes(); }
};

void dibuixar_formes(){
  background(0,0,0);
  //Crear cuadro
  for(var i=0; i<=100; i++){
    fill(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    noStroke();
    if (i % 3 == 0){ ellipse(random(0,800),random(0,600),random(10,200),random(10,200)); }
    if (i % 3 == 1){ rect(random(0,800),random(0,600),random(10,200),random(10,200)); }
    stroke(floor(random(0,255)),floor(random(0,255)),floor(random(0,255)));
    if (i % 3 == 2){ line(random(0,800),random(0,600),random(0,800),random(0,600)); }
  }
  //Prepara nova pantalla
  repinta=0;
};

void mouseClicked(){
  if (repinta === 0) { repinta = 1;}
};




