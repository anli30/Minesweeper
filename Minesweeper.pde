

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private int NUM_BOMBS = 50;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++){
      for(int col = 0; col < NUM_COLS; col++){
        buttons[row][col] = new MSButton(row,col);
      }
    }
    
    for(int i = 0; i <NUM_BOMBS;i++){
      setBombs();
    }
}
public void setBombs()
{
    //your code
    int randRow = (int)(Math.random()*NUM_ROWS);
    int randCol = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[randRow][randCol])){
      bombs.add(buttons[randRow][randCol]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int countClicks = 0;
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS;c++){
        if(buttons[r][c].clicked == true && !bombs.contains(buttons[r][c])){
          countClicks++;
        }
      }
    }
    if(countClicks == buttons.length - bombs.size()){
      return true;
    }else{
      return false;
    }
}
public void displayLosingMessage()
{
    //your code here\
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        //your code here
        if(mouseButton == RIGHT){
          if(clicked == false){
            marked = !marked; 
            if(marked == false){
              clicked = false;
            }
          }
        }else if(bombs.contains(this)){
          clicked = true;
          displayLosingMessage();
        }else if(countBombs(r,c) > 0){
          clicked = true;
          setLabel(""+ countBombs(r,c));
        }else{
          clicked = true;
          for(int i = r-1; i< r+2; i++){
            for(int j = c-1;j <c+2; j++){
               if(isValid(i,j) == true && buttons[i][j].clicked == false){
                 buttons[i][j].mousePressed();
               }
            }
          }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r<NUM_ROWS && r >= 0 && c >=0 && c < NUM_COLS){
        return true;
      }else{
        return false;
      }
    }
    public int countBombs(int row, int col)
    {
      int numBombs = 0;
       //your code here
      for(int i = row-1; i< row+2; i++){
         for(int j = col-1;j < col+2; j++){
           if(isValid(i,j)==true){
             if(i==row && j==col){
               numBombs = numBombs + 0;
             }else if(bombs.contains(buttons[i][j])){
               numBombs++;
             }else{
               numBombs = numBombs + 0;
             }
           }
         }
       }
       return numBombs;
    }
}
