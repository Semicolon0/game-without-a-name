
import processing.sound.*;
SoundFile file;
PImage playerImg;
PImage backgroundImg;
PImage enemyImg;

SoundFile playerHurtSfx;
SoundFile playerDeadSfx;
SoundFile playerAttackSfx;
SoundFile enemyDeathSfx;
SoundFile enemyLaughSfx;
SoundFile randomScreamSfx;
    
    Player player = new Player();
    int lineX = player.x;
    int lineY = player.y;
    Target target = new Target();
    int score = 0;
    boolean gameActive = true;
    int backgroundDeath = 118;
    int gameOverTextColor = 0;
    float musicVolume = 1.0;
    float musicSpeed = 1.1;
    int playerHealth = 2;
      //int eyeColorNum = 4;//eyecolor debugging
    int eyeColorNum =parseInt(random(1,5));
    color cursorColor = #1ee656;
    color cursorGreen = #1ee656;
    color cursorYellow = #fff200;
    color cursorRed = #ed1c23;
    color cursorBlue = #00a2e8;
    
    
public void setup(){
  System.out.println(eyeColorNum);
  size(700,500);
  file = new SoundFile(this, "assets/sounds/music/D_E1M1.mp3");
  playerHurtSfx = new SoundFile(this, "assets/sounds/sfx/playerHurt.mp3");
  playerDeadSfx = new SoundFile(this, "assets/sounds/sfx/playerDead.mp3");
  playerAttackSfx = new SoundFile(this, "assets/sounds/sfx/playerAttack.mp3");
  enemyDeathSfx = new SoundFile(this, "assets/sounds/sfx/enemyDeath.mp3");
  enemyLaughSfx = new SoundFile(this, "assets/sounds/sfx/enemyLaugh.mp3");
  randomScreamSfx = new SoundFile(this,"assets/sounds/sfx/randomScream.mp3");
  file.play();
  file.loop();

  if (eyeColorNum == 1){
    playerImg = loadImage("assets/sprites/playerHealthy.png");
    cursorColor = cursorGreen;
  } else if (eyeColorNum == 2){
     playerImg = loadImage("assets/sprites/playerHealthyYellow.png");
     cursorColor = cursorYellow;
  } else if (eyeColorNum ==3){
    playerImg = loadImage("assets/sprites/playerHealthyRed.png");
    cursorColor = cursorRed;
  } else if (eyeColorNum ==4){
    playerImg = loadImage("assets/sprites/playerHealthyBlue.png");
    cursorColor = cursorBlue;
  } else if (eyeColorNum == 5){
    playerImg = loadImage("assets/sprites/playerHealthy.png");
    cursorColor = cursorGreen;
  }

  backgroundImg = loadImage("assets/images/background image.png");
  enemyImg = loadImage("assets/sprites/enemy.png");
  noCursor();
}

public class Player {
  int x = 350;
  int y = 250;
  int speed = 5;
  
  void drawPlayer(){
    image(playerImg,player.x,player.y,60,60);
  }
  
  void movement(){
    if(gameActive == true){
    if(keyPressed) {
      if(key == 'a'||key == 'A'||keyCode == LEFT){
         if(this.x >= 0){
            this.x-=speed;  
         }
      } else if (key == 'd'||key == 'D'||keyCode == RIGHT){
        if(this.x+60 <= 700){
          this.x+=speed;
        }
      } else if (key == 'w'|| key == 'W'||keyCode == UP){
        if(this.y >= 0){
        this.y-=speed;
        }
      } else if (key == 's'|| key == 'S'||keyCode == DOWN){
        if(this.y+60 <=500){
        this.y+=speed;
        }
      }
    }
  }
}
}

public class Target{
  boolean targetAlive = false;
  int x = parseInt(random(50,650));
  int y = parseInt(random(50,450));
  float moveX = 1;
  float moveY = 1;
  
  public void newTarget(){
    if(targetAlive == false){
      fill(200,0,0);
      image(enemyImg,x,y,50,50);
    }
  }
  
  public void moveTarget(){
    if(gameActive == true){
    if(this.x != player.x && this.y != player.y){
      if(this.x > player.x && this.y > player.y){
      this.x -= this.moveX;
      this.y -= this.moveY; 
      } else if (this.x < player.x && this.y < player.y){
        this.x+=this.moveX;
        this.y+=this.moveY;
      } else if (this.x < player.x && this.y > player.y){
        this.x+=this.moveX;
        this.y-=this.moveY;
      }else if (this.x > player.x && this.y < player.y){
        this.x-=this.moveX;
        this.y+=this.moveY;
    }
  }
         if (this.x > player.x && this.y == player.y){
         this.x-=moveX;
       } else if (this.x < player.x && this.y == player.y){
         this.x+=moveX;
       } else if (this.y > player.y && this.x == player.x){
         this.y-=moveY;
       } else if (this.y < player.y && this.x == player.x){
         this.y+=moveY;
       }
  }}
  
  public void killPlayer(){
    if (this.x+50 >= player.x && this.x <= player.x+60 && this.y+50 >= player.y && this.y <= player.y+60){
      playerHealth--;
      x = parseInt(random(50,650));
      y = parseInt(random(50,450));
      if(playerHealth > 0){
              playerHurtSfx.play();      
      }
        if (eyeColorNum == 1){
    playerImg = loadImage("assets/sprites/playerHurt.png");
  } else if (eyeColorNum == 2){
     playerImg = loadImage("assets/sprites/playerHurtYellow.png");
  } else if (eyeColorNum ==3){
    playerImg = loadImage("assets/sprites/playerHurtRed.png");
  } else if(eyeColorNum == 4){
    playerImg = loadImage("assets/sprites/playerHurtBlue.png");
  } else if (eyeColorNum == 5 ){
    playerImg = loadImage("assets/sprites/playerHurt.png");
  }
      if(playerHealth == 0){
        playerDeadSfx.play();

      gameActive = false;
      }
  }}
  
  } //slutning på target class

  public void mouseReleased(){
    if (gameActive == true){
    lineX = mouseX;
    lineY = mouseY;
    playerAttackSfx.amp(0.05);
    playerAttackSfx.play();
    stroke(5);
  line(player.x+30,player.y+30,lineX,lineY);
  stroke(0);
  fill(0,0,200);
    fill(255);
    if(mouseX >= target.x && mouseX <= target.x+50 && mouseY >= target.y && mouseY <= target.y+50){
      target.x = parseInt(random(50,650));
      if (target.x <= player.x-50 && target.x >= player.x+50){
        target.x = parseInt(random(50,650));
      }
      target.y = parseInt(random(50,450));
      if(target.y <= player.y-50 && target.y >= player.y+50){
        target.y = parseInt(random(50,450));
      }
      enemyDeathSfx.amp(0.3);
      enemyDeathSfx.play();
      score++;
    } 
    }
  }

public void draw(){
  if(gameActive == true){
  if(parseInt(random(0,1000))==5){
    enemyLaughSfx.amp(0.05);
    enemyLaughSfx.play();
  }
  if(parseInt(random(0,1000000))==563){
    randomScreamSfx.amp(1.25);
    randomScreamSfx.play();
  }
  lineX = player.x;
  lineY = player.y;
  background(0,0,0);
  image(backgroundImg,0,0,700,500);
    line(player.x,player.y,lineX,lineY);
    
    stroke(cursorColor);
    strokeWeight(5);
    ellipse(mouseX, mouseY, 30,30);
            fill(cursorColor);
            strokeWeight(1);
    ellipse(mouseX, mouseY, 10,10);
    stroke(0);

  player.movement();
  player.drawPlayer();
  target.newTarget();
  target.moveTarget();
  fill(255);
  //rect(player.x-25,player.y-25,50,50);

  
  fill(255);
  textSize(24);
    text("score: " + score, 600,25);
  }
    if(gameActive == false){

    image(backgroundImg,0,0);
    background(backgroundDeath,0,0);
    backgroundDeath--; 
    if(gameOverTextColor != 255){
    gameOverTextColor++;
    musicVolume-=0.002;
     musicSpeed-= 0.002;
           fill(gameOverTextColor);
      textSize(96);
      text("GAME OVER",125,250);
    if(musicVolume >= 0.05){
    file.amp(musicVolume);
    }
    if(musicSpeed >= 0.05){}
    file.rate(musicSpeed);
    }
    if(gameOverTextColor == 255){
      textSize(52);
      fill(255);
      text("final score: " + score,220,350);
      fill(gameOverTextColor);
      textSize(96);
      text("GAME OVER",125,250);

    }
}
        target.killPlayer();
        
  
};
