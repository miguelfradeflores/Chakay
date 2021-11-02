float gyroscopeX, gyroscopeY, gyroscopeZ;
int screenWidth = 1500;
int screenHeight = 400;

int level =1;
int posFinalX=200;
int posFinalY=600;
int characterX =90;
int characterY =60;
int rectWidth;
int speedX = 5, speedY=5;
int radius = 20;



boolean victory = false;

void setup() {
  // size(screenWidth, screenHeight, P3D);
  size(1500,800);

}

void draw() {

  background(127,222,238);
  if (level==1){
    rect(250,0,20,400);
    rect(900,0,20,400);
    rect(590,360,20,400);
  } else if(level==2){
    rect(250,0,20,400);
    rect(900,0,20,400);
    rect(490,360,20,400);
    rect(450,0,25,200);
    rect(650,0,25,200);
    rect(390,360,20,400);
  }else if(level ==3){
    rect(450,0,25,200);
    rect(650,0,25,200);
    rect(390,360,20,400);
    rect(1000,300,300,80);  
  
  }

   ellipse(characterX,characterY,60,60);
   fill(257,73,174)  ;

     
    rect(posFinalX,posFinalY,100,10 );
    rect(posFinalX+45,posFinalY-45,10,100 );
   
   
   if(characterX>= posFinalX && characterX <=posFinalX+ (2*radius) && 
       characterY >= posFinalY-radius && characterY <=posFinalY+radius){
     victory=true;
   
   }
   
   
   if (victory == true){
   
     if( level ==1){
     level=2;
     posFinalX=1200;
     posFinalY=600;
     }else if(level==2){
     level=3;
     posFinalX=1200;
     posFinalY=200;
     }
  
  
     characterX = 90;
     characterY=60;
     victory=false;
     
     
   }
   
   
}

void keyPressed() {
  int keyIndex = -1;
  if (key == 'a' || key =='A' ) {
    characterX = characterX - speedX;
  } else if (key == 'd' || key == 'D') {
    characterX = characterX + speedX;
  } else if (key == 'w' || key == 'w') {
    characterY = characterY - speedY;
  } else if (key == 's' || key == 'S') {
    characterY = characterY + speedY;
  }



}
