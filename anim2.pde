float ox=300;
float oy=300;
float x,y;

void setup() { 
	size(1200,1200); 
	stroke(0); 
	smooth();
}


void touchMove(TouchEvent touchEvent) {
   noStroke();
   fill(255);
   rect(0, 0, width, height);
   
   fill(180, 180, 100);
   for (int i = 0; i < touchEvent.touches.length; i++) {
     int x = touchEvent.touches[i].offsetX;
     int y = touchEvent.touches[i].offsetY;

		float a = random(0,255);
		float b = random(0,255);
		float c = random(0,255);

		fill(a,b,c);  


		ellipse(ox,oy,x,y);
		ox = x;
		oy = y;
     
   }
}

