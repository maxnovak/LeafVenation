//Max Novak
//Leaf Venation
//COM-209
//October 2012
ParallelLeaf leaf1;
PinnateLeaf leaf2;
PalmingLeaf leaf3;
PImage parallel;
PImage pinnate;
PImage palmate;
int mouseCounter=0;
float randomNumber;

void setup(){
  size(800,600, P3D);
  randomNumber = random(1,2);//sets a random element for the vein diagrams
}

void mouseClicked(){
  mouseCounter += 1;//everytime the mouse is clicked adds one to the counter
  //Counter is used to determine which veination image is being drawn.
  //Mod 3 is used to cycle through the images
}

void draw(){
  background(255,255,255);
  //camera(width-mouseX,height-mouseY,(height/2) / tan(PI/6), width/2, height/2, 0,0,1,0);
  translate(width/2,height/2);
  rotateY(PI * frameCount / 500);
  translate(-width/2,-height/2);
  
  if (mouseCounter%3 == 1)
  {
    leaf1 = new ParallelLeaf(5.0,500.0, 10); //creates new leaf object
    parallel = loadImage("parallel.jpg");//loads image of veination
    leaf1.Parallel();//draws leaf veination
  }
  
  if (mouseCounter%3 == 2)
  {
    leaf2 = new PinnateLeaf(20,500.0);//creates new leaf object
    pinnate = loadImage("pinnate.jpeg");//loads image of veination
    leaf2.Pinnate();//draws leaf veination
  }
  
  if(mouseCounter%3 == 0)
  {
    leaf3 = new PalmingLeaf(150,500.0, 65);//creates new leaf object
    palmate = loadImage("palmate.jpeg");//loads image of veination
    leaf3.Palming();//draws leaf venation
  }
  
  
}

//Palming Leaf class

class PalmingLeaf{
  color c;
  float h;
  float hght;
  float angle;
  float theta;
  
  PalmingLeaf(float h, float hght,float angle){
        c = color(34,139,34);//Good Green is 34,139,34
                         //dark orange is 255,165,0
        this.h = h;
        this.hght = hght;
        this.angle = angle;
  }
  void Palming(){
    image(palmate,0,0,width/5,height/5);//draws the image of the correct veination
    theta = radians(angle);//creates theta in radians
    stroke(this.c);//sets color
    line(width/2,this.hght,width/2,0);//creates the initial center vein
    translate(width/2, this.hght*2/3);//moves the center for the drawing of the venation
    float left=this.h;
    LeftSide(left, 0.80);//begins a recursive draw of the left side of the venation
    float right=this.h;
    RightSide(right, 0.80);//begins a recursive draw of the right side of the venation

    
  }
  
  void LeftSide(float left, float amount){
    amount -=0.03;//decriments how much the shink is by as the recursian continues
    left *= amount;//shrinks the size of the branches
    
    if (left > 10) 
    {
      pushMatrix();
      rotate(theta);//rotates the branch
      line(0, 0, 0, -left);  //draws it
      translate(0, -left); //moves center
      LeftSide(left, amount);//recursian      
      popMatrix();     
      

      pushMatrix();
      rotate(0);//doesnt rotate but does the same steps again to make the brances continue up to the top of the central vein
      line(0, 0, 0, -left);
      translate(0, -left);
      LeftSide(left, amount);
      popMatrix();
    }
  }
  
  void RightSide(float right, float amount){
    amount -=0.03;//decriments how much the shink is by as the recursian continues
    right *= amount;//shrinks the size of the branches
    
    if (right > 10) //the following process is the same as for the left side, however it has a switched theta to do it with the opposite angle
    {
      pushMatrix();
      rotate(-theta);
      line(0, 0, 0, -right);
      translate(0, -right);
      RightSide(right, amount);
      popMatrix();
      
      pushMatrix();
      rotate(0);
      line(0, 0, 0, -right);
      translate(0, -right);
      RightSide(right, amount);
      popMatrix();
    }
  }
}


//Pinnate Leaf class

class PinnateLeaf{
  color c;
  float spacing;
  float hght;
  
  PinnateLeaf(float spacing, float hght){
    c = color(34,139,34);//Good Green is 34,139,34
                         //dark orange is 255,165,0
    this.spacing = spacing;
    this.hght = hght;
  }
  
  void Pinnate(){
    image(pinnate,0,0,width/5,height/5);//draws the image of the correct veination
    stroke(this.c);
    line(width/2,this.hght,width/2,0);//creates the initial center vein
    
    //makes the outline of the leaf
    bezier(width/2,this.hght-spacing,width/4,height/2,width/4,height/2,width/2,0);
    bezier(width/2,this.hght-spacing,width*3/4,height/2,width*3/4,height/2,width/2,0);
    
    //makes he veins within the leaf
    float multiplyBy = 4;//makes the leaves start at the right location might need to be changed for different spacings
    float scaling = 0.5;
    while (multiplyBy*spacing < this.hght-spacing)//cycles through until the veins reach the top of the leaf
    {
      
      //actually draws the veins using arcs
      arc(width/2,this.hght-multiplyBy*spacing,scaling*width/4,height/9,0,PI/2);
      arc(width/2,this.hght-multiplyBy*spacing,scaling*width/4,height/9,PI/2,PI);

      multiplyBy += randomNumber;//incraments how much the spacing is by to add a new vein
      float currentHeight = this.hght-multiplyBy*spacing;
      if (currentHeight > this.hght-this.hght/2)
      {
        scaling += .15;//scales the veins up in size until it reaches the widest part of the leaf
      }
      else
      {
        scaling -= .15;//scales down the veins size until it reaches the top of the leaf
      }
    }
  }
}

//Parallel Leaf class

class ParallelLeaf{
  color c;//allows the user to change the color of the veins
  float spacing;//allows the user to change the spacing between the veins
  float hght;//allows the user to change the height of the viens
  int numberOfVeins;//allows the user to change the number of veins
  
  ParallelLeaf(float spacing, float hght, int numberOfVeins){
    c = color(34,139,34);//Good Green is 34,139,34
                         //dark orange is 255,165,0 for fall colors
    this.spacing = spacing;
    this.hght = hght;
    this.numberOfVeins = numberOfVeins;
  }
  
  void Parallel(){
    image(parallel,0,0,width/5,height/5);//draws the image of the correct veination
    stroke(this.c);
    line(width/2,0,width/2,this.hght);//creates the initial center vein
    for (int i=1; i<=this.numberOfVeins/2; i++)//then loops through and creates two veins on each side of the center vein
    {
      line(width/2-this.spacing*i,0,width/2-this.spacing*i,this.hght);
      line(width/2+this.spacing*i,0,width/2+this.spacing*i,this.hght);
    }
  }
}

