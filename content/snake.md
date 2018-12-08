---
title: "Snake"
date: 2017-11-10T12:43:17-05:00
draft: false
---

```java
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JPanel;


public class Snake extends JPanel implements KeyListener{

    private static final long serialVersionUID = 1L;
    /***************Environment************************/
    public static final int SIZE = 10;
    public static final int SIZEE = Snake.SIZE * Snake.SIZE;
    /***************Position*****************/
    private int gstartx = Snake.SIZE * 2;
    private int gstarty = Snake.SIZE * 2;
    /***************Constants************************/
    public static final int EMPTY = 0;
    public static final int FOOD = 1;
    public static final int SNAKENODE = 2;
    public static final int STONE = 3;
    public static final int STONE2 = 4;
    public static final int STONE3 = 5;
    /***************Directions************************/
    public static final int UP = 0;
    public static final int RIGHT = 1;
    public static final int DOWN = 2;
    public static final int LEFT = 3;
    /***************Variables************************/
    private int[][] matrix ;
    private SnakeNode[] littlesnake ;
    private SnakeNode head ;
    private int headx ;
    private int heady ;
    private int len ;
    private Food food ;
    private int direction ;
    private boolean isAlive ;

    public static void main(String[] args) {
        Snake snake = new Snake();
        JFrame f = new JFrame();
        f.setContentPane(snake);
        f.setLocation(900-Snake.SIZE*Snake.SIZE>=0?800-Snake.SIZE*Snake.SIZE:0, 400-Snake.SIZE*Snake.SIZE>=0?600-Snake.SIZE*Snake.SIZE:0);
        f.setSize(20*Snake.SIZE<1024?20*Snake.SIZE:1024, 20*Snake.SIZE<768?20*Snake.SIZE:768);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setResizable(false);
        f.addKeyListener(snake);
        f.setVisible(true);
        snake.go();
    }

    public Snake(){
        init();
    }

    /***************Init************************/
    public void init(){
        matrix = new int[Snake.SIZE][Snake.SIZE];
        littlesnake = new SnakeNode[SIZEE];
        food = new Food();

        SnakeNode node1 = new SnakeNode(2,3);
        SnakeNode node2 = new SnakeNode(2,2);
        SnakeNode node3 = new SnakeNode(2,1);

        littlesnake[0] = node1;
        littlesnake[1] = node2;
        littlesnake[2] = node3;
        len = 3;
        head = littlesnake[0];

        food = getFood();

        direction = Snake.RIGHT;
        isAlive = true;

    }

    /***************Entrance************************/
    private void go() {
        while(isAlive){
            Move();
            setScreen();
            repaint();
            try {
                Thread.sleep((long) (500-(Snake.SIZE-10)*3.5));
            } catch (InterruptedException e) {
                e.printStackTrace();
                System.out.println("Thread sleep Exception !!");
            }
        }
    }

    /***************Logical≠************************/
    private void Move(){
        switch (direction){
            case Snake.UP:
                headx = head.getNodex()-1;
                heady = head.getNodey();
                break;
            case Snake.RIGHT:
                headx = head.getNodex();
                heady = head.getNodey()+1;
                break;
            case Snake.DOWN:
                headx = head.getNodex()+1;
                heady = head.getNodey();
                break;
            case Snake.LEFT:
                headx = head.getNodex();
                heady = head.getNodey()-1;
                break;
        }
        if(isMoveable(headx, heady)){
            if(isFood(headx, heady)){
                littlesnake[len] = new SnakeNode(littlesnake[len-1].getNodex(),littlesnake[len-1].getNodey());
                len ++;
                food = getFood();
            }
            for(int t=len-1;t>0;t--){
                littlesnake[t].setNodex(littlesnake[t-1].getNodex());
                littlesnake[t].setNodey(littlesnake[t-1].getNodey());
            }
            switch (direction){
                case Snake.UP:
                    head.setNodex(head.getNodex()-1);
                    break;
                case Snake.RIGHT:
                    head.setNodey(head.getNodey()+1);
                    break;
                case Snake.DOWN:
                    head.setNodex(head.getNodex()+1);
                    break;
                case Snake.LEFT:
                    head.setNodey(head.getNodey()-1);
                    break;
            }
        }else
            isAlive = false;
    }
    private boolean isMoveable(int x,int y){
        return (x>-1&&x<Snake.SIZE&&y>-1&&y<Snake.SIZE) && (matrix[x][y] < Snake.SNAKENODE);
    }
    private boolean isFood(int x,int y){
        return Snake.FOOD == matrix[x][y];
    }

    /***************Data***********************/
    private Food getFood(){
        while(matrix[food.getFoodx()][food.getFoody()]!=Snake.EMPTY){
            food.setFoodx(new Random().nextInt(Snake.SIZE));
            food.setFoody(new Random().nextInt(Snake.SIZE));
        }
        return food;
    }

    private void setScreen(){
        for(int i=0;i<Snake.SIZE;i++)
            for(int j=0;j<Snake.SIZE;j++)
                matrix[i][j] = Snake.EMPTY;
        //matrix[5][5] = Snake.STONE;
        //matrix[6][6] = Snake.STONE2;
        //matrix[7][7] = Snake.STONE3;
        for(int t=0;t<len;t++)
            matrix[littlesnake[t].getNodex()][littlesnake[t].getNodey()] = Snake.SNAKENODE;
        matrix[food.getFoodx()][food.getFoody()] = Snake.FOOD;
    }

    /***************Display***********************/
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        if(isAlive)
            screen(g);
        else
            gameOver(g);
    }

    private void screen(Graphics g){
        int i;
        int j;

        g.drawString("+", gstartx, gstarty);
        for(i=0;i<Snake.SIZE;i++)
            g.drawString("-", gstartx+12+i*12, gstarty);
        g.drawString("+", gstartx+12+i*12, gstarty);

        for(i=0;i<Snake.SIZE;i++)
        {
            g.drawString(" [", gstartx, gstarty+12+i*12);
            for(j=0;j<Snake.SIZE;j++)
            {
                switch (matrix[i][j]){
                    case Snake.EMPTY: g.drawString(".", gstarty+16+j*12, gstartx+14+i*12);break;
                    case Snake.SNAKENODE: g.drawString("@", gstarty+12+j*12, gstartx+14+i*12);break;
                    case Snake.FOOD: g.drawString("O", gstarty+14+j*12, gstartx+14+i*12);break;
                    case Snake.STONE: g.drawString("!", gstarty+14+j*12, gstartx+14+i*12);break;
                    case Snake.STONE2: g.drawString("#", gstarty+14+j*12, gstartx+14+i*12);break;
                    case Snake.STONE3: g.drawString("&", gstarty+14+j*12, gstartx+14+i*12);break;
                }
            }
            g.drawString(" ]", gstarty+12+j*12, gstartx+12+i*12);
        }

        g.drawString("+", gstartx, gstarty + (Snake.SIZE + 1) * 12);
        for(i=0;i<Snake.SIZE;i++)
            g.drawString("-", gstartx+12+i*12, gstarty + (Snake.SIZE + 1) * 12);
        g.drawString("+", gstartx + (Snake.SIZE + 1) * 12, gstarty + (Snake.SIZE + 1) * 12);
    }

    private void gameOver(Graphics g) {
        g.setFont(new Font("ITCKRIST",Font.BOLD,20));
        g.drawString("Game Over!!", 30, 50);
        g.setFont(new Font("serif",Font.BOLD,25));
        g.drawString("You are DEAD!!", 15, 100);
    }

    /***************Actions***********************/
    public void keyPressed(KeyEvent e) {
        switch (e.getKeyCode()){
            case KeyEvent.VK_UP: if(direction != Snake.DOWN)direction = Snake.UP;break;
            case KeyEvent.VK_RIGHT: if(direction != Snake.LEFT)direction = Snake.RIGHT;break;
            case KeyEvent.VK_DOWN: if(direction != Snake.UP)direction = Snake.DOWN;break;
            case KeyEvent.VK_LEFT: if(direction != Snake.RIGHT)direction = Snake.LEFT;break;
        }
    }

    public void keyReleased(KeyEvent e) {}
    public void keyTyped(KeyEvent e) {}


    public class SnakeNode {

        private int nodex;
        private int nodey;

        public SnakeNode(int x,int y){
            nodex = x;
            nodey = y;
        }

        public int getNodex() {
            return nodex;
        }
        public void setNodex(int nodex) {
            this.nodex = nodex;
        }
        public int getNodey() {
            return nodey;
        }
        public void setNodey(int nodey) {
            this.nodey = nodey;
        }
    }

    public class Food {
        private int foodx = 0;
        private int foody = 4;

        public int getFoodx() {
            return foodx;
        }
        public void setFoodx(int foodx) {
            this.foodx = foodx;
        }
        public int getFoody() {
            return foody;
        }
        public void setFoody(int foody) {
            this.foody = foody;
        }
    }
}
```
