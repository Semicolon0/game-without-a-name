import processing.sound.*;
SoundFile file;
    
    Player player = new Player();
    int lineX = player.x;
    int lineY = player.y;
    Target target = new Target();
    int score = 0;
    boolean gameActive = true;
    int backgroundDeath = 200;
    int gameOverTextColor = 0;
    float musicVolume = 1.0;
    float musicSpeed = 1.1;
public void setup(){
  size(700,500);
  file = new SoundFile(this, "D_E1M1.mp3");
  file.play();
  file.loop();
  
}

public class Player {
  int x = 350;
  int y = 250;
  
  void movement(){
    if(gameActive == true){
    if(keyPressed) {
      if(key == 'a'){
         if(this.x-25 >= 0){
            this.x-=5;  
         }
      } else if (key == 'd'){
        if(this.x+25 <= 700){
          this.x+=5;
        }
      } else if (key == 'w'){
        if(this.y-25 >= 0){
        this.y-=5;
        }
      } else if (key == 's'){
        if(this.y+25 <=500){
        this.y+=5;
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
      rect(x,y,40,40);
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
    if (this.x == player.x &&  this.y ==player.y){
      fill(gameOverTextColor);
      textSize(96);
      text("GAME OVER",125,250);
      gameActive = false;
  }}
  
  } //slutning på target class

  public void mouseReleased(){
    if (gameActive == true){
    lineX = mouseX;
    lineY = mouseY;
  line(player.x,player.y,lineX,lineY);
  fill(0,0,200);
    rect(mouseX-25,mouseY-25,50,50);
    fill(255);
    if(mouseX >= target.x && mouseX <= target.x+40 && mouseY >= target.y && mouseY <= target.y+40){
    System.out.println("target hit");
      target.x = parseInt(random(50,650));
      target.y = parseInt(random(50,450));
      score++;
       System.out.println(target.moveX + ", " + target.moveY);
    } 
    }
  }

public void draw(){
  lineX = player.x;
  lineY = player.y;
  background(0,200,0);
    line(player.x,player.y,lineX,lineY);
    

  player.movement();
  target.newTarget();
  target.moveTarget();
  fill(255);
  rect(player.x-25,player.y-25,50,50);
  
  fill(0);
  textSize(24);
    text("score: " + score, 600,25);
    if(gameActive == false){
    background(0,backgroundDeath,0);
    backgroundDeath--; 
    if(gameOverTextColor != 255){
    gameOverTextColor++;
    musicVolume-=0.002;
     musicSpeed-= 0.002;
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

    }
}
        target.killPlayer();
        
  
};
