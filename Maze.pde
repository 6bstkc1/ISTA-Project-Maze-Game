/*
*  Maze object 
*/

class Maze {
 
  int rows;
  int cols;
  int w;
  Node maze[][];
  
  Maze(int wid, int heig, int w)
  {
    this.rows = wid/w;
    this.cols = heig/w;
    this.w = w;
    maze = new Node[rows][cols];
    initMaze(maze);
    
  }
  
  /*
  *  Builds a maze using depth first search alg
  */
  void initMaze(Node[][] maze)
  {
    
    //init all the nodes
   for(int i = 0; i < rows; i++)
    for(int j = 0; j < cols; j++)
      maze[i][j] = new Node(i,j); 
      
    Node cur = maze[0][0]; // start building location 
    cur.setVisited(true);
    
    Node next = cur.randNeighbor(maze);
    
    ArrayList<Node> stack = new ArrayList<Node> (); // stack
    
    //Maze building time
    while(stack.size() != 0 || next != null)
    {
     next = cur.randNeighbor(maze);
     if(next != null)
     {
       stack.add(cur);
       
       cur.removeWalls(cur,next);
       next.setVisited(true);
       
       cur = next; 
     }
     else if(stack.size() > 0)
     {
       Node n = stack.get(stack.size()-1); // Pop the element
       stack.remove(stack.size()-1);
       cur = n;
     }
     else
       print("Building maze still.\n");
      }
     maze[0][0].setPlayerLocation(true); // Player start
     maze[rows-1][cols-1].setEndLocation(true); // End location
     print("Null\n");  
    }  
    
  /*
  *  Draws the maze to the screen
  */
  void drawMaze()
  {
    for(int i = 0; i < rows; i++)
      for(int j = 0; j < cols; j++)
        maze[i][j].show(w);
  }
  
  boolean getWall(int i, int j, int wall)
  {
    return maze[i][j].getWallAt(wall);
  }
  
  Node getNode(int i, int j)
  {
    return maze[i][j];
  }
}
  
  
  