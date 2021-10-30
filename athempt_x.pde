float gyroscopeX, gyroscopeY, gyroscopeZ;


void setup() {
   size(screenWidth, screenHeight, P3D);
}

void draw() {
   background(127,222,238);
	rect(250,0,20,400)
	rect(900,0,20,400)
	rect(590,360,20,400)
	ellipse(90,60,60,60)
	ellipse(1050,60,60,60)

   translate(width/2,height/2,0);
   translate(900*gyroscopeX,500*gyroscopeY,500*gyroscopeZ);
   box( random(40,60));
   box( 30) 
	fill(257,73,174)  
   
}

//experimental feature
void gyroscopeUpdated(float x, float y, float z) {

}

//experimental feature
void accelerometerUpdated(float x, float y, float z) {
   gyroscopeX = x;
   gyroscopeY = y;
   gyroscopeZ = z;	   
}

	
