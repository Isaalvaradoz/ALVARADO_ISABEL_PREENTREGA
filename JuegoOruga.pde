//Juego ORUGA
//1. Nace la oruga en su huevo
//2. La oruga empieza a moverse
//3. La oruga come hojas
//4. La oruga se prepara para el capullo
//5. La oruga se convierte en capullo
//6. Nace la mariposa


//VARIABLES DEL JUEGO

//Dice que pantalla está el juego
int pantalla;

//Pantalla 0: Intro
PImage hojas;
int huevosOrugaX = 400;
int huevosOrugaY = 500;
color colorHuevos;
int totalHuevos = 10;
Huevo[] grupoHuevos = new Huevo[totalHuevos];
int huevosRotos = 0;
boolean mostrarBoton1=false;

//Pantalla 1: La oruga se mueve
Oruga oruga1;



void setup()
{
  size(800, 800);
  imageMode(CENTER);
  textMode(CENTER);
  rectMode(CENTER);
  noStroke();

  //Comienza eljuego en la pantalla 0
  pantalla=0;
  hojas = loadImage("hojas.png");
  
  //ESCENA 1 -FRESAS
  // Inicializar fresas
  for (int i = 0; i < totalHuevos; i++) {
    grupoHuevos[i] = new Huevo(huevosOrugaX,huevosOrugaY);
    huevosOrugaX+=15;
    huevosOrugaY+=15;
    
    if(i==4)
    {
      huevosOrugaX = 400;
      huevosOrugaY+=5;
    } 
  }
  
  //ESCENA 2 - ORUGA1
  oruga1 = new Oruga(200,500);
}

void draw()
{
  background(255);

  if (pantalla==0)
  {
    dibujaIntro();
  }
  
  if (pantalla==1)
  {
    dibujaEscena2();
  }
  
  if (pantalla==2)
  {
    dibujaEscena3();
  }
}



//FUNCIONES DE CADA PANTALLA

//Primera pantalla intro
void dibujaIntro()
{
  image(hojas,400,400);
  
  for(Huevo h1:grupoHuevos)
  {
    if(h1.tam>100)
    {
      colorHuevos = color(mouseX/2,180,mouseX/2);
      h1.tamMax=true;
      huevosRotos+=1;
      
      if(huevosRotos>10)
      {
        mostrarBoton1=true;
      }
    }
    else
    {
      colorHuevos = color(50,255,50);
      h1.tamMax=false;
      huevosRotos=0;
    }
    
    
    h1.dibujar(colorHuevos); 
  }
  
  if(mostrarBoton1==true)
  {
    fill(#AEF0B6);
    rect(width/2,height/2-200,400,150,20);
    rect(width/2,height/2,100,60,20);
    
    fill(0);
    textSize(32);
    text("Las orugas están listas para \n    salir de sus huevos",width/2-180,height/2-200);
    textSize(26);
    text("seguir",width/2-30,height/2);
  }
  else
  {
    fill(#AEF0B6);
    rect(width/2,height/2-300,350,100,20);
    
    fill(0);
    textSize(32);
    text("Ayuda a las orugas a \n    salir de sus huevos",width/2-150,100);
  }
  
}


//Dibuja la pantalla 2
void dibujaEscena2()
{
  //Hoja imagen de fondo 
  image(hojas,400,600,1600,1600);
  
  //Huevo de donde sale la oruga
  stroke(0);
  strokeWeight(2);
  fill(colorHuevos);
  ellipse(100,400,300,400);
  fill(#CEC4B7);
  ellipse(170,480,60,100);
  
  //Oruga
  oruga1.dibujar();
  
  //Este es el punto a donde debe llegar para avanzar de nivel
  stroke(255,20,20);
  noFill();
  strokeWeight(4);
  ellipse(700,200,50,100);
  noStroke();
  //Rectangulo y texto
  fill(255);
  rect(620,100,280,80,20);
  fill(0);
  textSize(20);
  text("Llega hasta acá para \ncomenzar a comer de la hoja",500,100);
  
  //Si la oruga llega al circulo rojo pasa al siguiente nivel
  if( oruga1.x > 600 && oruga1.y<220)
  {
    pantalla=2;
  }
}

//Dibuja la pantalla 3, donde la oruga come las hojas
void dibujaEscena3()
{
  //Hoja imagen de fondo
  image(hojas,100,650,2000,2000);
  
  fill(#AEF0B6);
  rect(width/2,height/2-200,400,150,20);  
  fill(0);
  textSize(32);
  text("Aquí la oruga comienza a \n comerse la hoja",width/2-180,height/2-200);  
}


//OTRAS FUNCIONES

//Cuando se hace click
void mousePressed()
{
  if(pantalla==0)
  {
    //Si hace click en el boton de la pnatalla 1
    if(mostrarBoton1==true && mouseX>350 && mouseX<450 && mouseY>370 && mouseY<430)
    {
      pantalla=1;
    }
  }
}

//Cuando se presionan las teclas
void keyPressed()
{
  if(pantalla==1)
  {
    if (keyCode == LEFT)  oruga1.x -= 10;
    if (keyCode == RIGHT) oruga1.x += 10;
    if (keyCode == UP) oruga1.y -= 10;
    if (keyCode == DOWN) oruga1.y += 10;
  }
}


//CLASES

//Huevo de donde nace la oruga
class Huevo
{
  int tam;
  boolean tamMax;
  int x;
  int y;

  Huevo(int posX, int posY)
  {
    x = posX;
    y = posY;
    tam = 20;
    tamMax = false;
  }

  void dibujar(color d)
  {
    stroke(0);
    strokeWeight(2);
    fill(d);
    ellipse(x, y, tam/3, tam/2);
    
    if( dist(mouseX,mouseY,x,y)<tam && tamMax==false )
    {
      tam+=1;
    }
  }
}


//La oruga que se mueve en la pantalla 1
class Oruga
{
  int tam;
  boolean tamMax;
  int x;
  int y;
  color col = color(100,255,20);
  
   Oruga(int posX, int posY)
  {
    x= posX;
    y = posY;
    tam = 15;
    tamMax = false;
  }

  void dibujar()
  {
    fill(col);
    
    //Cuerpo de 5 circulos
    for(int i=0; i<5;i++)
    {
      int pos = x+(i*22);
      int t = tam+(i*12);
      
      circle(pos, y, t);
    }
    
    //Cara
    fill(0);
    noStroke();
    ellipse(x+75,y-10,10,13);
    ellipse(x+105,y-10,10,13);
    fill(255);
    ellipse(x+78,y-12,2,2);
    ellipse(x+108,y-12,2,2);
    fill(0);
    arc(x+93,y+5,30,30,0, PI, CHORD);
    
  }
}
