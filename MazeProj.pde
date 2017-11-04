/*
* Builds a maze, using a Depth-First Search Recursive algorithm
*/

// OH NO GLOBAL VARS!
int rows;
int cols;
int w;
Node cur, next;
Node[][] grid;
ArrayList<Node> stack; // Arraylist used as a stack, processing has no stack data structure

void setup() {
  fullScreen(); // See the maze
  background(0);
  //frameRate(60); // Controls rate of maze draw
  w = 40;
  rows = width / w;
  cols = height / w;
  grid = new Node[rows][cols]; // Screen size and w effect the size of the maze
  stack = new ArrayList<Node> ();
  
  for(int i = 0; i < rows; i++)
    for(int j = 0; j < cols; j++)
      grid[i][j] = new Node(i,j);
      
  cur = grid[0][0];
  cur.setVisited(true);
}      

void draw() {
  for(int i = 0; i < rows; i++)
    for(int j = 0; j < cols; j++)
      grid[i][j].show(w);
   
   //Begin the algorithm
   // Step 1
   next = cur.randNeighbor(grid);
   if(next != null)
   {
     // Step 2
     stack.add(cur);
      
     //Step 3
     cur.removeWalls(cur,next);
     next.setVisited(true);
     
     //Step 4
     cur = next; 
   }
   else if(stack.size() > 0)
   {
     Node n = stack.get(stack.size()-1); // Pop the element
     stack.remove(stack.size()-1);
     cur = n;
   }
   else
     print("Null\n");
}