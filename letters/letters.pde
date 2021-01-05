// Global variables        
var tamx = 640;
var tamy = 480;
var lim_sup = 50;
var lim_inf = 450;
var energia = 100;
var puntos = 0;
int[][][] letras = {{"R", 100 , 120}};

// Setup Processing Canvas
void setup() {
  size(tamx, tamy);
  background(0,0,0);
  cursor(CROSS);
  inicializa(0);
}

void draw(){
  background(0,0,0);
  fill(255,0,0);
  rect (0,lim_inf,tamx,tamy);
  if (energia>0){
    mostrar_letras();    
  }
  mostrar_textos();  
}

void sumar_target(){	
  letras = append(letras, {100,0,0});	
  inicializa(letras.length - 1);	
}

void inicializa(pos){
  letras[pos][0]=char(random(48,122));
  letras[pos][1]=random(0,tamx);
  letras[pos][2]=lim_sup;	
}

void mostrar_letras(){
  var i = 0;
  while(i < letras.length){
    fill(255,255,0);
    textSize(18);
    text(letras[i][0], letras[i][1], letras[i][2]);
    letras[i][2]+=1;     
    //Si target llega 
    if (letras[i][2]>lim_inf){
      var sound = new Howl({urls: ['blip.wav']}).play();
      energia-=1;
      inicializa(i);
    }    
    i+=1;
  }
}


void keyPressed(){
  var i = 0;
  while(i < letras.length){
    //println("PULSADA: " + key + " = " + int(letras[i][0]));
    if (key == int(letras[i][0])) {
     //println(letras[i][0]);
      var sound = new Howl({urls: ['pop.wav']}).play();
      puntos+=1; 
      inicializa(i);
      sumar_target();
    }
    i+=1;
  }

}


void mostrar_textos(){
  fill(255,0,0);
  textAlign(CENTER);
  textSize(18);
  text("ENERGY: " + energia, tamx / 2, 30);	  

  fill(255,0,0);
  textAlign(RIGHT);
  textSize(18);
  text("POINTS: " + puntos, tamx - 50, 30);
 
  if (energia<=0){
	energia=0;
    fill(255,255,255);
    textSize(45);
    textAlign(CENTER);
    text("GAME OVER", tamx / 2, tamy / 2);
  }

}


