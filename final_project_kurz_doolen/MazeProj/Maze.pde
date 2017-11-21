/*
*  Maze object 
*/

class Maze {
 
  int rows;
  int cols;
  int w; //Used to determine maze size
  Node maze[][];
  float c1 = random(255);
  float c2 = random(255);
  float c3 = random(255);
  
  /*
  *  Constructor
  */
  Maze(int wid, int heig, int w) {
    this.rows = wid/w;
    this.cols = heig/w;
    this.w = w;
    maze = new Node[rows][cols];
    initMaze(maze);
  }
  
  /*
  *  Builds a maze using depth first search alg
  */
  void initMaze(Node[][] maze) {
    
    //init all the nodes
   for(int i = 0; i < rows; i++)
     for(int j = 0; j < cols; j++)
       maze[i][j] = new Node(i, j, c1, c2, c3); 
      
    Node cur = maze[0][0]; // start building location 
    cur.setVisited(true);
    
    Node next = cur.randNeighbor(maze);
    
    ArrayList<Node> stack = new ArrayList<Node> (); // stack (no stacks in processing)
    
    //Maze building time
    while(stack.size() != 0 || next != null) {
     next = cur.randNeighbor(maze);
     if(next != null) {
       stack.add(cur);
       cur.removeWalls(cur,next);
       next.setVisited(true);
       cur = next; 
     }
     else if(stack.size() > 0) {
       Node n = stack.get(stack.size()-1); // "Pop" the element
       stack.remove(stack.size()-1);
       cur = n;
     }
     maze[0][0].setPlayerLocation(true); // Player start
     maze[rows-1][cols-1].setEndLocation(true); // End location  
    }
    //Reset the visited value
    for(int i = 0; i < rows; i++)
     for(int j = 0; j < cols; j++)
       maze[i][j].setVisited(false);
  }
    
  /*
  *  Draws the maze to the screen
  */
  void drawMaze() {
    for(int i = 0; i < rows; i++)
      for(int j = 0; j < cols; j++)
        maze[i][j].show(w);
  }
 
  /*
  *  Gets a specific wall at a node, given the coordinates
  */
  boolean getWall(int i, int j, int wall) {
    return maze[i][j].getWallAt(wall);
  }
 
  /*
  *  Returns a node at some specific coordinates
  */
  Node getNode(int i, int j) {
    return maze[i][j];
  }
}