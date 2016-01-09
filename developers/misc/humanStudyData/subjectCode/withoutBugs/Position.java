package ch06Code;

//********************************************************************
//  Position.java       Author: Lewis/Chase
//
//  Represents a single position in a maze of characters.
//********************************************************************

public class Position
{
  private int x; 
  private int y;

  /*******************************************************************
    Constructs a position and sets the x & y coordinates to 0,0.
  *******************************************************************/
  public Position ()
  {
    x = 0;
    y = 0;
  }

  /*******************************************************************
    Returns the x-coordinate value of the current position.
  *******************************************************************/
  public int getx()
  {
    return x;
  }

  /*******************************************************************
    Returns the y-coordinate value of the current position.
  *******************************************************************/
  public int gety()
  {
    return y;
  }

  /*******************************************************************
    Sets the value of the current position's x-coordinate.
  *******************************************************************/
  public void setx(int a)
  {
    x = a;
  }

  /*******************************************************************
    Sets the value of the current position's y-coordinate.
  *******************************************************************/  
  public void sety(int a)
  {
    y = a;
  }
}
