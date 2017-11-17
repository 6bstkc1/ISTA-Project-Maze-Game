/*
* main()
*/

Maze maze;
int playerX = 0;
int playerY = 0;

void setup() {
  fullScreen(); // See the maze
  frameRate(30);
  background(0);
  int sizeControl = 100;
  maze = new Maze(width,height,sizeControl);
}      

void draw() {
  maze.drawMaze();
  if(keyPressed)
  {
      Node oldNode = maze.getNode(playerX,playerY);
      Node newNode = maze.getNode(playerX,playerY);
      if(keyCode == UP)
      {
          if(!maze.getWall(playerX,playerY,0)) //No wall!
          {
            newNode = maze.getNode(playerX,playerY-1);
            playerY--;
          }
      }
       else if (keyCode == DOWN)
       {
          if(!maze.getWall(playerX,playerY,2)) //No wall!
          {
            newNode = maze.getNode(playerX,playerY+1);
            playerY++;
          }
       }
       else if (keyCode == LEFT)
       {
          if(!maze.getWall(playerX,playerY,3)) //No wall!
          {
            newNode = maze.getNode(playerX-1,playerY);
            playerX--;
          }
       }
       else if (keyCode == RIGHT)
       {
          if(!maze.getWall(playerX,playerY,1)) //No wall!
          {
            newNode = maze.getNode(playerX+1,playerY);
            playerX++;
          }
       }
       oldNode.setPlayerLocation(false);
       newNode.setPlayerLocation(true);
  }
}