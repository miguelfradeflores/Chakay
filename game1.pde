float gyroscopeX, gyroscopeY, gyroscopeZ;
int screenWidth = 1500;
int screenHeight = 400;

int level = 0;
int posFinalX=1050;
int posFinalY=60;
int characterX =90;
int characterY =60;
int rectWidth;
int speedX = 3, speedY=3;   // spped in which the character moves
int radius = 20;
int character_radius = 45;
int originX=60;   // X position to restart character if it collides to a wall
int originY=60;  // Y position to restart character if it collides to a wall


int level_wallsX [][]= {{250,900,590,200}, {250,900,550,100,550}, {250,900,550,100,590,0,1100}  };
int level_wallsY [][]= {{0,0,360,600}, {0,0,360,600,0}, {0,0,360,700,0,300,300}  };
int level_walls_width [][] = {{20,20,20,800},{20,20,20,950,20},{20,20,20,950,20,100,100}};
int level_walls_height [][] = {{400,400,400,20},{400,400,400,20,200},{600,600,400,20,200,20,20}};

int level_obstacle [] = {4,5,7};  // array of level obstacles length

boolean victory = false; // boolean used to change level and restart character position

void setup() {
  size(1300,800);

}

void draw() {
  background(127,222,238);


  // CREATE OBSTACLES
    //if (level==0){
    //  rect(250,0,20,400);
    //  rect(900,0,20,400);
    //  rect(590,360,20,400);
    //  rect(200,600,800,20);
    //} else if(level==1){
    //  rect(250,0,20,400);
    //  rect(900,0,20,400);
    //  rect(590,360,20,400);
    //  rect(100,600,950,20);
    //  rect(590,0,20,200);
    //}else if(level ==2){
    //  rect(250,0,20,600);
    //  rect(900,0,20,600);
    //  rect(590,360,20,400);
    //  rect(100,700,950,20);
    //  rect(590,0,20,200);
    //  rect(0,300,100,20);
    //  rect(1100,300,100,20);
    //}


  // create obstacles with for loop
    for (int i=0;i<level_obstacle[level];i++ ){
      rect( level_wallsX[level][i], level_wallsY[level][i], level_walls_width[level][i],level_walls_height[level][i] );
    }


   ellipse(characterX,characterY,60,60);
   fill(257,73,174)  ;

     
    rect(posFinalX,posFinalY,100,10 );
    rect(posFinalX+45,posFinalY-45,10,100 );
   
   // Check if character is near the final position
   if(characterX>= posFinalX && characterX <=posFinalX+ 100 && 
       characterY >= posFinalY-45 && characterY <=posFinalY+100){
     victory=true;
   
   }
   
   // check victory flag to change level
   if (victory == true){   
     if( level ==0){
       level=1;
     }else if(level==1){
      level=2;
     }
  
     characterX = 90;
     characterY=60;
     victory=false;
        
   }
   
   
}

void keyPressed() {
  
  if (key == 'a' || key =='A' ) {

    for (int i =0;i< level_obstacle[level] ;i++){ //iterate through all the walls to check if character collide with one wall
      if ( characterX +character_radius > level_wallsX[level][i] && characterX - character_radius < level_wallsX[level][i] + level_walls_width[level][i] && 
        characterY + character_radius > level_wallsY[level][i] && characterY - character_radius < level_wallsY[level][i] + level_walls_height[level][i] ){
        characterX= originX;
        characterY=originY;
    }else{ // if no collision, then move character
        characterX = characterX - speedX;
      }
      
    }

  //  if (canMove == true){
//    }
  } else if (key == 'd' || key == 'D') {
    for (int i =0;i<level_obstacle[level];i++){
 if ( characterX +character_radius > level_wallsX[level][i] && characterX - character_radius < level_wallsX[level][i] + level_walls_width[level][i] && 
        characterY + character_radius > level_wallsY[level][i] && characterY - character_radius < level_wallsY[level][i] + level_walls_height[level][i] ){
        characterX= originX;
        characterY= originY;
    }else{
        characterX = characterX + speedX;
      }
      
    }
  } else if (key == 'w' || key == 'w') {
    for (int i =0;i<level_obstacle[level];i++){
      if ( characterX +character_radius > level_wallsX[level][i] && characterX - character_radius < level_wallsX[level][i] + level_walls_width[level][i] && 
        characterY + character_radius > level_wallsY[level][i] && characterY - character_radius < level_wallsY[level][i] + level_walls_height[level][i] ){
        characterX= originX;
        characterY=originY;
      }else{
       characterY = characterY - speedY;
      }
      
    }
  } else if (key == 's' || key == 'S') {
    for (int i =0;i<level_obstacle[level];i++){
      if ( characterX +character_radius > level_wallsX[level][i] && characterX - character_radius < level_wallsX[level][i] + level_walls_width[level][i] && 
           characterY + character_radius > level_wallsY[level][i] && characterY - character_radius < level_wallsY[level][i] + level_walls_height[level][i] ){
        characterX= originX;
        characterY=originY;
      }else{
       characterY = characterY + speedY;
      }
    }
  }


}
