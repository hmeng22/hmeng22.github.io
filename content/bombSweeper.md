---
title: "BombSweeper"
date: 2017-11-10T12:44:09-05:00
draft: false
---

```java
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;
import javax.swing.JButton;


public class BombSweeper extends JFrame implements ActionListener, MouseListener {

    private static final long serialVersionUID = 1L;

    /**
     * Menu
     **/
    private JMenuBar menubar;
    private JMenu menu;
    private JMenuItem start;
    private JMenuItem restart;
    private JMenuItem levels;
    private JMenuItem record;
    private JMenuItem exit;

    /**
     * Panel
     **/
    private JPanel mainpanel;
    private BombCube[][] bombcubes;

    private JPanel west;
    private JPanel north;

    private JPanel south;
    private JLabel RBLabel;
    private JLabel TimeLabel;

    private Timer timer;
    private int second;


    /**
     * Window
     **/
    private Container container;

    /**
     * Data
     **/
    private int level = 0;                                    //difficulty
    private int Block[][] = {{9, 9}, {16, 16}, {16, 30}};        //rows and columns
    private int Size[][] = {{363, 404}, {620, 664}, {1145, 654}};//window size
    private int BlockNum[] = {81, 256, 480};                    //cell number
    private int BombNum[] = {10, 40, 99};                        //bomb number

    private int OpenedBlock, RemainedBlock;        //opened cell number, remained cell number
    private int FindedBomb, RemainedBomb;        //found bomb number, remained bomb number

    // directions
    private int varI[] = {-1, -1, -1, 0, 1, 1, 1, 0};
    private int varJ[] = {-1, 0, 1, 1, 1, 0, -1, -1};

    // Colors : 0-opened cell' color, 1-8-numbers' color, 9-cell's color
    private Color color[] = {Color.BLACK, new Color(70, 80, 190), new Color(20, 110, 0), new Color(170, 10, 0), new Color(0, 0, 120), new Color(120, 0, 0), new Color(0, 130, 120), new Color(170, 0, 0), new Color(160, 0, 20), Color.LIGHT_GRAY};

    // tips
    private String title[] = {"Easy", "Beginner", "Hard"};
    private String failuremessages[] = {"Exit", "Restart", "Play Again"};
    private String successmessages[] = {"Another Round", "Exit"};

    public BombSweeper() {
        super.setTitle("BombSweeper - " + title[level]);

        initGame();

        startGame();
    }

    public static void main(String[] args) {
        new BombSweeper();
    }

    /**
     * Initilization
     */
    // Initlizaiton
    public void initGame() {
        initData();
        initView();
    }

    // init data
    public void initData() {
        OpenedBlock = 0;
        RemainedBlock = BlockNum[level] - OpenedBlock;

        FindedBomb = 0;
        RemainedBomb = BombNum[level] - FindedBomb;

        timer = new Timer();
        second = 1;
    }

    // init views
    public void initView() {
        /**≤Àµ•¿∏**/
        menubar = new JMenuBar();
        menu = new JMenu("Game");
        start = new JMenuItem("New Game");
        start.setMargin(new Insets(0, 0, 0, 0));
        start.addActionListener(this);
        restart = new JMenuItem("Play it Again");
        restart.setMargin(new Insets(0, 0, 0, 0));
        restart.addActionListener(this);
        levels = new JMenuItem("Levels");
        levels.setMargin(new Insets(0, 0, 0, 0));
        levels.addActionListener(this);
        record = new JMenuItem("info");
        record.setMargin(new Insets(0, 0, 0, 0));
        record.addActionListener(this);
        exit = new JMenuItem("Exit");
        exit.setMargin(new Insets(0, 0, 0, 0));
        exit.addActionListener(this);
        menu.add(start);
        menu.add(restart);
        menu.addSeparator();
        menu.add(levels);
        menu.addSeparator();
        menu.add(record);
        menu.addSeparator();
        menu.add(exit);
        menubar.add(menu);

        /** Panel **/
        mainpanel = new JPanel();
        mainpanel.setLayout(new GridLayout(Block[level][0], Block[level][1]));
        mainpanel.setBackground(Color.BLACK);

        bombcubes = new BombCube[Block[level][0]][Block[level][1]];
        for (int i = 0; i < Block[level][0]; i++)
            for (int j = 0; j < Block[level][1]; j++) {
                bombcubes[i][j] = new BombCube(i, j);
                bombcubes[i][j].setFont(new Font("Arial", Font.BOLD, 30));
                bombcubes[i][j].setForeground(Color.RED);
                bombcubes[i][j].setBackground(color[9]);
                bombcubes[i][j].setMargin(new Insets(0, 0, 0, 0));
                bombcubes[i][j].addActionListener(this);
                bombcubes[i][j].addMouseListener(this);
            }

        for (int i = 0; i < Block[level][0]; i++)
            for (int j = 0; j < Block[level][1]; j++)
                mainpanel.add(bombcubes[i][j]);

        /** Panels **/
        /*
      Layout Panels
     */
        JPanel east = new JPanel();
        east.setBackground(Color.DARK_GRAY);
        west = new JPanel();
        west.setBackground(Color.DARK_GRAY);
        north = new JPanel();
        north.setBackground(Color.DARK_GRAY);

        south = new JPanel();
        south.setLayout(new GridLayout(1, 4));
        south.setBackground(Color.DARK_GRAY);
        RBLabel = new JLabel();
        RBLabel.setFont(new Font("Monospaced", Font.BOLD, 20));
        RBLabel.setText("Bombs :" + RemainedBomb);
        RBLabel.setForeground(Color.WHITE);
        RBLabel.setHorizontalAlignment(SwingConstants.CENTER);
        TimeLabel = new JLabel();
        TimeLabel.setFont(new Font("Monospaced", Font.BOLD, 20));
        TimeLabel.setText("Time :" + 0);
        TimeLabel.setForeground(Color.WHITE);
        TimeLabel.setHorizontalAlignment(SwingConstants.CENTER);
        south.add(RBLabel);
        south.add(TimeLabel);


        /** Window **/
        container = getContentPane();
        container.removeAll();
        container.setLayout(new BorderLayout());
        container.add(mainpanel, "Center");
        container.add(east, "East");
        container.add(west, "West");
        container.add(south, "South");
        container.add(north, "North");

        setJMenuBar(menubar);
        setSize(Size[level][0], Size[level][1]);
        setLocation(100, 50);
        setResizable(false);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    // Reset Views
    public void resetView() {
        RBLabel.setText("Bombs :" + RemainedBomb);
        TimeLabel.setText("Time :" + 0);
    }

    /**
     * Functions
     */
    // Start
    public void startGame() {
        initData();
        resetView();
        initBombs();
    }

    // Restart
    public void restartGame() {
        initData();
        resetView();
        initBombcubes();
    }

    // Exit
    public void exitGame() {
        System.exit(0);
    }

    /**
     * Functions
     */
    // init bombs
    public void initBombs() {
        initBombcubes();
        ClearBombs();
        LandBombs();
        CalcAroundBombs();
    }

    // reset bombs
    public void initBombcubes() {
        for (int i = 0; i < Block[level][0]; i++)
            for (int j = 0; j < Block[level][1]; j++) {
                bombcubes[i][j].isOpened = false;
                bombcubes[i][j].isFlaged = false;
                bombcubes[i][j].setEnabled(true);
                bombcubes[i][j].setText("");
                bombcubes[i][j].setBackground(color[9]);
            }
    }

    // clear all
    public void ClearBombs() {
        for (int i = 0; i < Block[level][0]; i++)
            for (int j = 0; j < Block[level][1]; j++) {
                bombcubes[i][j].isBomb = false;
                bombcubes[i][j].AroundBombs = 0;
            }
    }

    // land randomly
    public void LandBombs() {
        for (int t = 0; t < BombNum[level]; t++) {
            int x = (int) (Math.random() * Block[level][0] - 1);
            int y = (int) (Math.random() * Block[level][1] - 1);

            if (bombcubes[x][y].isBomb)
                t--;
            else
                bombcubes[x][y].isBomb = true;
        }
    }

    // calculation
    public void CalcAroundBombs() {
        for (int i = 0; i < Block[level][0]; i++) {
            for (int j = 0; j < Block[level][1]; j++) {
                if (!bombcubes[i][j].isBomb) {
                    for (int t = 0; t < 8; t++) {
                        if (!isOutofBounds(i + varI[t], j + varJ[t]) && bombcubes[i + varI[t]][(j + varJ[t])].isBomb)
                            bombcubes[i][j].AroundBombs++;
                    }
                }
            }
        }
    }

    // display all bombs
    public void displayBombs() {
        for (int i = 0; i < Block[level][0]; i++) {
            for (int j = 0; j < Block[level][1]; j++) {
                if (bombcubes[i][j].isBomb) {
                    bombcubes[i][j].setText("X");
                    bombcubes[i][j].setBackground(color[0]);
                }
            }
        }
    }

    // open Action
    public void openBlock(int i, int j) {
        if (bombcubes[i][j].isBomb) {
            displayBombs();

            timer.cancel();

            int selected = JOptionPane.showOptionDialog(this, "Game Over !!", "Lose", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE, null, failuremessages, failuremessages[2]);
            if (selected == JOptionPane.OK_OPTION) {
                exitGame();
            } else if (selected == JOptionPane.NO_OPTION) {
                restartGame();
            } else if (selected == JOptionPane.CANCEL_OPTION) {
                startGame();
            }
        } else {
            if (bombcubes[i][j].AroundBombs == 0)
                digIt(i, j);
            if (bombcubes[i][j].AroundBombs != 0 && !bombcubes[i][j].isFlaged) {
                bombcubes[i][j].setText(bombcubes[i][j].AroundBombs + "");
                bombcubes[i][j].isOpened = true;
                bombcubes[i][j].setEnabled(false);
                bombcubes[i][j].setBackground(color[bombcubes[i][j].AroundBombs]);

                OpenedBlock++;
                RemainedBlock = BlockNum[level] - OpenedBlock;
            }
        }
    }

    public void digIt(int i, int j) {
        if (isOutofBounds(i, j) || bombcubes[i][j].isOpened || bombcubes[i][j].isFlaged)
            return;

        if (bombcubes[i][j].AroundBombs != 0) {

            bombcubes[i][j].setText(bombcubes[i][j].AroundBombs + "");
            bombcubes[i][j].isOpened = true;
            bombcubes[i][j].setEnabled(false);
            bombcubes[i][j].setBackground(color[bombcubes[i][j].AroundBombs]);

            OpenedBlock++;
            RemainedBlock = BlockNum[level] - OpenedBlock;
            return;
        }

        if (bombcubes[i][j].AroundBombs == 0) {
            bombcubes[i][j].setText("");
            bombcubes[i][j].isOpened = true;
            bombcubes[i][j].setEnabled(false);
            bombcubes[i][j].setBackground(color[0]);

            OpenedBlock++;
            RemainedBlock = BlockNum[level] - OpenedBlock;
        }

        for (int t = 0; t < 8; t++)
            digIt(i + varI[t], j + varJ[t]);
    }

    /**
     * Rules Function
     */
    // outboundary ?
    public boolean isOutofBounds(int i, int j) {
        return !(i >= 0 && i < Block[level][0] && j >= 0 && j < Block[level][1]);
    }

    // Complete?
    public boolean isCompleted() {
        if (RemainedBlock == BombNum[level]) {
            displayBombs();
            return true;
        }
        return false;
    }

    /**
     * Actions
     */
    @Override
    public void actionPerformed(ActionEvent e) {

        if (e.getSource() == start) {
            startGame();
        } else if (e.getSource() == restart) {
            restartGame();
        } else if (e.getSource() == levels) {
            int selected = JOptionPane.showOptionDialog(this, "Levels:", "Difficulty", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE, null, title, title[2]);
            if (selected == JOptionPane.OK_OPTION) {
                level = 0;
                super.setTitle("BombSweeper - " + title[level]);
                initGame();
                startGame();
            } else if (selected == JOptionPane.NO_OPTION) {
                level = 1;
                super.setTitle("BombSweeper - " + title[level]);
                initGame();
                startGame();
            } else if (selected == JOptionPane.CANCEL_OPTION) {
                level = 2;
                super.setTitle("BombSweeper - " + title[level]);
                initGame();
                startGame();
            }
        } else if (e.getSource() == record) {
            System.out.println(getWidth() + "   " + getHeight());
        } else if (e.getSource() == exit) {
            exitGame();
        } else {
            /** Timer **/
            if (second < 2) {
                timer.schedule(new TimerTask() {
                    @Override
                    public void run() {
                        TimeLabel.setText(" Time :" + second++);
                    }
                }, 100, 1000);
            }

            BombCube bombcube = (BombCube) e.getSource();

            openBlock(bombcube.x, bombcube.y);

            if (isCompleted()) {

                /** Done **/
                timer.cancel();

                int selected = JOptionPane.showOptionDialog(this, "Congratulations !!", "Win !!", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE, null, successmessages, successmessages[0]);
                if (selected == JOptionPane.OK_OPTION) {
                    startGame();
                } else if (selected == JOptionPane.NO_OPTION) {
                    exitGame();
                }
            }
        }
    }

    @Override
    public void mouseClicked(MouseEvent e) {
        BombCube bombcube = (BombCube) e.getSource();
        boolean right = SwingUtilities.isRightMouseButton(e);
        if (right && !bombcube.isOpened) {
            if (!bombcube.isFlaged) {
                bombcube.setText("F");
                bombcube.isFlaged = true;
                FindedBomb++;
                RemainedBomb = BombNum[level] - FindedBomb;

                RBLabel.setText("Bombs :" + RemainedBomb);
            } else {
                bombcube.setText("");
                bombcube.isFlaged = false;
                FindedBomb--;
                RemainedBomb = BombNum[level] - FindedBomb;

                RBLabel.setText("Bombs :" + RemainedBomb);
            }
        }
    }

    @Override
    public void mouseEntered(MouseEvent e) {
    }

    @Override
    public void mouseExited(MouseEvent e) {
    }

    @Override
    public void mousePressed(MouseEvent e) {
    }

    @Override
    public void mouseReleased(MouseEvent e) {
    }

    public class BombCube extends JButton {
        private static final long serialVersionUID = 1L;

        public int x, y;            // row and column
        public int AroundBombs;    // bombs aournt it
        public boolean isBomb;        //  is bomb ?
        public boolean isOpened;    //  is opened ?
        public boolean isFlaged;    //  is flagged ?

        public BombCube(int x, int y) {
            this.x = x;
            this.y = y;
            AroundBombs = 0;
            isBomb = false;
            isOpened = false;
            isFlaged = false;
        }
    }
}
```
