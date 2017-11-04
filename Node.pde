/*
*  Acts as the traversal object in the maze
*/

class Node
{
  int i;
  int j;
  boolean visited;
  boolean[] walls;
  
  /*
  *  Node Constructor
  */
  Node(int i, int j)
  {
    this.i = i;
    this.j = j;
    visited = false;
    walls = new boolean[]{true,true,true,true};
  }
  
  /*
  *  Gets the visted value.
  */
  boolean getVisited()
  {
    return visited;
  }
  
  /*
  *  Returns a random neighbor node next to this node.
  */
  Node randNeighbor(Node[][] grid)
  {
    ArrayList<Node> neighbors = new ArrayList<Node>(); // Collection of neighbors
    
    // Make sure the index is valid and the valid index has not been visited
    if(validIndex(i,j-1,grid) && !grid[i][j-1].getVisited()) // Top
      neighbors.add(grid[i][j-1]);
    if(validIndex(i+1,j,grid) && !grid[i+1][j].getVisited()) // Right
      neighbors.add(grid[i+1][j]);
    if(validIndex(i,j+1,grid) && !grid[i][j+1].getVisited()) // Bottom
      neighbors.add(grid[i][j+1]);
    if(validIndex(i-1,j,grid) && !grid[i-1][j].getVisited()) // Left
      neighbors.add(grid[i-1][j]);
    
    
    if(neighbors.size() > 0)
    {
      int randLoc = (int)random(neighbors.size()); // Choose a random neighbor
      return neighbors.get(randLoc);
    }
    else // No valid neighbors
      return null;
  }
  
  /*
  *  Removes the walls between two nodes
  */
  void removeWalls(Node cur, Node next)
  {
    int x = cur.i - next.i; // Left & right
    if(x == 1) // Left
    {
       cur.walls[3] = false; 
       next.walls[1] = false;
    }
    if(x == -1) // Right
    {
       cur.walls[1] = false; 
       next.walls[3] = false;
    }
    
    int y = cur.j - next.j; // Up and down
    if(y == 1) // Down
    {
       cur.walls[0] = false; 
       next.walls[2] = false;
    }
    if(y == -1) // Up
    {
       cur.walls[2] = false; 
       next.walls[0] = false;
    }
  }
  
  /*
  *  Changes the value of visited
  */
  void setVisited(boolean visited)
  {
     this.visited = visited; 
  }
  
  /*
  *  Draws the node and its walls to the screen
  */
  void show(int w)
  {
    int x = i * w;
    int y = j * w;
    
    stroke(255);
    if(walls[0]) // top
      line(x,y,x+w,y);
    if(walls[1])
      line(x+w,y,x+w,y+w); // right
    if(walls[2])
      line(x+w,y+w,x,y+w); // bottom
    if(walls[3])
      line(x,y+w,x,y); // left
    
    if(visited)
    {
      noStroke();
      fill(255,0,255,100);
      rect(x,y,w,w);
    } 
  }
  
  /*
  *  Checks if the index is valid
  */
  boolean validIndex(int i, int j, Node[][] grid)
  {
    return i > -1 && i < grid.length && j > -1 && j < grid[0].length;
  }
}