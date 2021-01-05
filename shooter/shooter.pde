// Global variables        
var tamx = 640;
var tamy = 480;
var ammo = 8;
var energy = 100;
var limit_sup = 99
var limit_inf = 10;
var puntos = 0;
int[][][] targets = {{320, 240, 10}};

// Setup Processing Canvas
void setup() {
  size(tamx, tamy);
  background(0,0,0);
  cursor(CROSS);
}

void draw(){
  background(0,0,0);
  if (energy != 0){mostrar_targets();}  
  control_vidas(); 
}

void mouseClicked() {
	if (energy == 0){}else{		    
		ammo = ammo - 1;
		var i=0;
		var contacto=0;
		while(contacto == 0 && i<targets.length){
			if ((mouseX >= (targets[i][0] - targets[i][2])) && (mouseX <= (targets[i][0] + targets[i][2])) && (mouseY >= (targets[i][1] - targets[i][2])) && (mouseY <= (targets[i][1] + targets[i][2]))){
				
				puntos = puntos + limit_sup - targets[i][2];
				ammo = ammo + 1;				
				contacto = 1;				
				var sound = new Howl({urls: ['pop.wav']}).play();
				//Reposiciona target
				reposiciona(i);
				//Aumenta targets
				if ( ( puntos - (targets.length * 250) ) > 0 ){sumar_target();}
			}
		i+=1;
		}
		if (contacto == 0){
		  var sound = new Howl({urls: ['ah.wav']}).play();	
		}
		

	}  
}

void reposiciona(pos){

	targets[pos][0]=50+floor(random(tamx-100));
	targets[pos][1]=100+floor(random(tamy-150));
	targets[pos][2]=limit_inf;	

}

void mostrar_targets(){  
  var i = 0;
  while(i < targets.length){	
	fill(targets[i][0],targets[i][1],energy);
    ellipse(targets[i][0],targets[i][1],targets[i][2],targets[i][2]);
    targets[i][2]+=1;     
	
	//Si target llega a tamaño máximo
	if (targets[i][2]==limit_sup){
	  energy-=1;
	  var sound = new Howl({urls: ['blip.wav']}).play();
	  reposiciona(i);
	}
    i+=1;
  }
 
}

void sumar_target(){	
	targets = append(targets, {0,0,0});	
	reposiciona(targets.length - 1);	
}


void control_vidas(){
  if (ammo == 0){energy = 0;}
  if (energy<=0){
	energy=0;
    fill(255,255,255);
    textSize(45);
    textAlign(CENTER);
    text("GAME OVER", tamx / 2, tamy / 2);
  }

  fill(255,0,0);
  textAlign(LEFT);
  textSize(18);
  text("AMMO: " + ammo, 50, 30);

  fill(255,0,0);
  textAlign(CENTER);
  textSize(18);
  text("ENERGY: " + energy, tamx / 2, 30);	  
  
  textAlign(RIGHT);
  textSize(18);
  text("POINTS: " + puntos, tamx - 50, 30);
}

