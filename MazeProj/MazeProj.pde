import processing.video.*;

Maze maze;
int sizeControl = 100;
int playerX = 0;
int playerY = 0;
int frame;
int rate = 21;
boolean strobe;
boolean last = false;
Capture cam;

void setup() {
  fullScreen();
  frameRate(60);
  background(255);
  
  noStroke();
  for (int i = 0; i < width * height; i++) {
    float x = random(width);
    float y = random(height);
    float fill = random(255);
    
    fill(fill);
    rect(x, y, 4, 4);
  }
 
  maze = new Maze(width, height, sizeControl);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }
  cam = new Capture(this, cameras[0]);
  cam.start();
}      

void draw() {
  
  if (sizeControl <= 60) {
    if (cam.available() == true) {
      cam.read();
    }
    image(cam, 0, 0, width, height);
  }
  else {
    
    frame++;
    maze.drawMaze();
    if (keyPressed && frame % 6 == 0) {
  
      Node oldNode = maze.getNode(playerX, playerY);
      Node newNode = maze.getNode(playerX, playerY);
  
      if (keyCode == UP) {
        if (!maze.getWall(playerX, playerY, 0)) {
          newNode = maze.getNode(playerX, playerY-1);
          playerY--;
        }
      } else if (keyCode == DOWN) {
        if (!maze.getWall(playerX, playerY, 2)) {
          newNode = maze.getNode(playerX, playerY+1);
          playerY++;
        }
      } else if (keyCode == LEFT) {
        if (!maze.getWall(playerX, playerY, 3)) {
          newNode = maze.getNode(playerX-1, playerY);
          playerX--;
        }
      } else if (keyCode == RIGHT) {
        if (!maze.getWall(playerX, playerY, 1)) {
          newNode = maze.getNode(playerX+1, playerY);
          playerX++;
        }
      }
  
      oldNode.setPlayerLocation(false);
      newNode.setPlayerLocation(true);
  
      if (newNode.getIsEndLocation()) {
        
        last = true;
        maze.drawMaze();
        last = false;
        
        sizeControl -= 10;
        rate -= 5;
  
        maze = new Maze(width, height, sizeControl);
  
        oldNode.setPlayerLocation(false);
        newNode.setPlayerLocation(false);
  
        playerX = 0;
        playerY = 0;
      }
    }
  }
}