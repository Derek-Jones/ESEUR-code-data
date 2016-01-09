package ch18;
import javax.swing.JFrame;
import java.awt.Graphics;
import java.awt.Color;


public class Face extends JFrame
{
    public static final int WINDOW_WIDTH = 400;
    public static final int WINDOW_HEIGHT = 400;


    public static final int FACE_DIAMETER = 200;
    public static final int X_FACE = 100;
    public static final int Y_FACE = 100;


    public static final int EYE_WIDTH = 20;
    public static final int X_RIGHT_EYE = X_FACE + 55;
    public static final int Y_RIGHT_EYE = Y_FACE + 60;
    public static final int X_LEFT_EYE = X_FACE + 130;
    public static final int Y_LEFT_EYE = Y_FACE + 60;


    public static final int MOUTH_WIDTH = 100;
    public static final int X_MOUTH = X_FACE + 50;
    public static final int Y_MOUTH = Y_FACE + 150;


    public static void main(String[] args)
    {
        Face drawing = new Face( );
        drawing.setVisible(true);
    }


    public Face( )
    {
        super("First Graphics Demo");
        setSize(WINDOW_WIDTH, WINDOW_HEIGHT);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        getContentPane( ).setBackground(Color.white);
    }


    public void paint(Graphics g)
    {
        super.paint(g);
        g.drawOval(X_FACE, Y_FACE, FACE_DIAMETER, FACE_DIAMETER);
        //Draw Eyes:
        g.drawLine(X_RIGHT_EYE, Y_RIGHT_EYE, 
                                 X_RIGHT_EYE + EYE_WIDTH,Y_RIGHT_EYE);
        g.drawLine(X_LEFT_EYE, Y_LEFT_EYE,
                                X_LEFT_EYE + EYE_WIDTH, Y_LEFT_EYE);
        //Draw Mouth:
        g.drawLine(X_MOUTH, Y_MOUTH, X_MOUTH + MOUTH_WIDTH, Y_MOUTH);
    }
}
