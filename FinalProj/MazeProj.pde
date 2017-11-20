import processing.video.*;

Maze [] mazes; //Array of mazes
int mazeCount = 5; //Number of mazes to be generated
int mazeIndex; // Used to draw certain mazes
int sizeControl = 100;
int playerX = 0;
int playerY = 0;
int frame;
int rate = 21;
boolean strobe;
boolean tutorialComplete; //Used to check if the tutorial is done
Capture cam;

void setup() {
  fullScreen();
  frameRate(60);
  background(0);
  
  /*noStroke();
  for (int i = 0; i < width * height; i++) {
    float x = random(width);
    float y = random(height);
    float fill = random(255);
    
    fill(fill);
    rect(x, y, 4, 4);
  }*/
 
 mazes = new Maze[5];
 //Generate mazes at start
  for(int i = 0; i < mazeCount; i++)
  {
    mazes[i] = new Maze(width, height, sizeControl);
    sizeControl-=10;
  }
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }
  cam = new Capture(this, cameras[0]);
  cam.start();
}      

void draw() {
  
  //Start tutorial text
  if(key == ENTER && !tutorialComplete)
  {
    tutorialComplete = true;
    clear();
  }
  else if(!tutorialComplete)
  {
    tutorialText();
  }
  else
  {
  
    if (mazeIndex == mazeCount) {
      if (cam.available() == true) {
        cam.read();
      }
      image(cam, 0, 0, width, height);
      fill(255);
      text("Press ENTER to exit",width/3.2,height/1.11);
      if(keyPressed) 
        if(key == ENTER)
            exit(); // end of program  
    }
    else {
      
      frame++;
      mazes[mazeIndex].drawMaze();
      if (keyPressed && frame % 6 == 0) {
    
        Node oldNode = mazes[mazeIndex].getNode(playerX, playerY);
        Node newNode = mazes[mazeIndex].getNode(playerX, playerY); // avoid null memes
    
        if (keyCode == UP) {
          if (!mazes[mazeIndex].getWall(playerX, playerY, 0)) {
            newNode = mazes[mazeIndex].getNode(playerX, playerY-1);
            playerY--;
          }
        } else if (keyCode == DOWN) {
          if (!mazes[mazeIndex].getWall(playerX, playerY, 2)) {
            newNode = mazes[mazeIndex].getNode(playerX, playerY+1);
            playerY++;
          }
        } else if (keyCode == LEFT) {
          if (!mazes[mazeIndex].getWall(playerX, playerY, 3)) {
            newNode = mazes[mazeIndex].getNode(playerX-1, playerY);
            playerX--;
          }
                    } else if (keyCode == RIGHT) {
                      if (!mazes[mazeIndex].getWall(playerX, playerY, 1)) {
                        newNode = mazes[mazeIndex].getNode(playerX+1, playerY);
                        playerX++;
                      }
                    }
    
        oldNode.setPlayerLocation(false);
        newNode.setPlayerLocation(true);
    
        if (newNode.getIsEndLocation()) {
          
          mazeIndex++; // On to the next maze
       
          rate -= 5;
    
          playerX = 0;
          playerY = 0;
          clear();
        }
      }
    }
  }
}

/*
*  Shows some tutorial text to help out new players
*/
void tutorialText()
{
  fill(255);
  textSize(40);
  text("Welcome!\n You must navigate through " +mazeCount + " mazes.\n Use the arrow keys to move.\n Press ENTER to continue.",width/3,height/3); 
}