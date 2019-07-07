import java.util.Arrays;
int[][] field = new int[13][4];
PFont font;
int turn = 0;
int wn=0;
int st=0;
Player p1=new Player("you",1);
Computer p2=new Computer("NPC1",2);
Computer p3=new Computer("NPC2",3);
Computer p4=new Computer("NPC3",4);

void setup(){
  size(1000,1000);
  frameRate(200);
}

void draw(){
  setting();
  gamemake();
  fill(225,0,0);
  text(turn,35,55);
}

void gamemake(){
  if(p1.hand+p2.hand+p3.hand+p4.hand>0||turn==0){
     switch(turn){
       case 0:
       gamestart();
       break;
       case 1:
       if(p1.hand<=0){
         turn++;
       }
       else {
         gameplay();
       }
       break;
       case 2:
       p2.play();
       turn++;
       break;
       case 3:
       p3.play();
       turn++;
       break;
       case 4:
       p4.play();
       turn=1;
       break;
     }
  }
  else {
    finish();
  }
}

void gameplay(){
  if(st==1){
    int x=0;
    field[6][1]=1;
    p1.hand--;
    for(int i=0;i<p1.hand;i++){
      if(p1.card[i]==207){
        x=i;
      }
    }
    p1.card[x]=500;
    p1.sort();
    fieldset(6,1);
    turn++;
    st=0;
  }
  else if(mousePressed&&mouseY>=560&&720>=mouseY){
    int x=mouseX/75;
    while(x>=p1.hand){
      if(mousePressed&&mouseY>=560&&720>=mouseY){
        x=mouseX/75;
      }
    }
    int m=(p1.card[x]/100)-1;
    int n=(p1.card[x]%100)-1;
    if(field[n][m]==2){
      field[n][m]=1;
      p1.hand--;
      p1.card[x]=500;
      p1.sort();
      fieldset(n,m);
      turn++;
    }
  }
  else if(mousePressed&&900<mouseX&&mouseX<width&&525<mouseY&&mouseY<560){
    turn++;
  }
}

void finish(){
  Player s=p1;
  wn=p1.pn;
  if(s.killed>p2.killed||s.killed==p2.killed&&s.kill<p2.kill){
    s=p2;
    wn=p2.pn;
  }
  if(s.killed>p3.killed||s.killed==p3.killed&&s.kill<p3.kill){
    s=p3;
    wn=p3.pn;
  }
  if(s.killed>p4.killed||s.killed==p4.killed&&s.kill<p4.kill){
    s=p4;
    wn=p4.pn;
  }
}

void killchecker(int n,int m){
  if(m!=0){
    if(m<3&&field[n][m+1]!=1){
        killedcheck(n,m+1);
    }
    if(field[n][m-1]!=1){
      killedcheck(n,m-1);
    }
    if(n==0&&field[n+1][m]!=1){
      killedcheck(n+1,m);
    }
    else if(n==12&&field[n-1][m]!=1){
      killedcheck(n-1,m);
    }
    else if(0<n&&n<12){
      if(field[n-1][m]!=1){
         killedcheck(n-1,m);
      }
      if(field[n+1][m]!=1){
         killedcheck(n+1,m);
      }
    }
  }
  else if(m==0){
    if(field[n][m+1]!=1){
      killedcheck(n,m+1);
    }
    if(n==0){
      if(field[n+1][m]!=1){
        killedcheck(n+1,m);
      }
    }
    else if(n==12){
      if(field[n-1][m]!=1){
         killedcheck(n-1,m);
      }
    }
    else if(0<n&&n<12){
      if(field[n-1][m]!=1){
         killedcheck(n-1,m);
      }
      if(field[n+1][m]!=1){
         killedcheck(n+1,m);
      }
    }
  }
}

void killedcheck(int n,int m){
  int s=0;
  if(m==0){
    if(n==0){
      s=1;
    }
    else if(n==12){
      s=3;
    }
    else {
      s=2;
    }
  }
  else if(m==3){
    if(n==0){
      s=7;
    }
    else if(n==12){
      s=9;
    }
    else {
      s=8;
    }    
  }
  else if(m==1||m==2){
    if(n==0){
      s=4;
    }
    else if(n==12){
      s=6;
    }
    else {
      s=5;
    }    
  }
  switch(s){
    case 1:
    if(field[n+1][m]==1&&field[n][m+1]==1){
      killedfield(n,m);
    }
    break;
    case 2:
    if(field[n-1][m]==1&&field[n+1][m]==1&&field[n][m+1]==1){
      killedfield(n,m);
    }
    break;
    case 3:
    if(field[n-1][m]==1&&field[n][m+1]==1){
      killedfield(n,m);
    }
    break;
    case 4:
    if(field[n+1][m]==1&&field[n][m+1]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
    case 5:
    if(field[n-1][m]==1&&field[n+1][m]==1&&field[n][m+1]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
    case 6:
    if(field[n-1][m]==1&&field[n][m+1]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
    case 7:
    if(field[n+1][m]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
    case 8:
    if(field[n-1][m]==1&&field[n+1][m]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
    case 9:
    if(field[n-1][m]==1&&field[n][m-1]==1){
      killedfield(n,m);
    }
    break;
  }
}

void killedfield(int n,int m){
  int x=(m+1)*100+n+1;
  field[n][m]=-1;
  if(turn==1){
    p1.kill++;
  }
  else if(turn==2){
    p2.kill++;
  }
  else if(turn==3){
    p3.kill++;
  }
  else if(turn==4){
    p4.kill++;
  }
  for(int i=0;i<p1.hand;i++){
    if(p1.card[i]==x){
      p1.card[i]=500;
      p1.hand--;
      p1.killed++;
      p1.sort();
    }
  }
  if(p2.can[n][m]==1){
    p2.can[n][m]=0;
    p2.hand--;
    p2.killed++;
  }
  else if(p3.can[n][m]==1){
    p3.can[n][m]=0;
    p3.hand--;
    p3.killed++;
  }
  if(p4.can[n][m]==1){
    p4.can[n][m]=0;
    p4.hand--;
    p4.killed++;
  }
    
}

void setting(){
  background(255,255,255); 
  font=loadFont("ArialMT-48.vlw");
  textFont(font,50);
  fill(0,0,0);
  for(int i=1;i<10;i++){
    text(i,65*(i-1)+100,50);
  }
  text(10,675,50);
  text("J",760,50);
  text("Q",815,50);
  text("K",885,50);
  spade(45,100,80);
  heart(45,280,80);
  diamond(45,300,100);
  clover(45,410,80);
  GUI();
  UI();
  FI();
}

void FI(){
  for(int i=0;i<13;i++){
    for(int j=0;j<4;j++){
      if(field[i][j]==1){
        switch(j){
          case 0:
          spade(65*i+120,115,50);
          break;
          case 1:
          heart(65*i+120,265,50);
          break;
          case 2:
          diamond(65*i+120,315,65);
          break;
          case 3:
          clover(65*i+120,425,50);
          break;
        }
      }
    }
  }
}

void GUI(){
  int m;
  int n;
  textFont(font,30);
  stroke(0,0,0);
  noFill();
  rect(0,525,140,35);
  text("your card",5,550);
  rect(900,525,100,35);
  text("pass?",905,550);
  textFont(font,50);
  fill(0,0,0);
  line(0,560,1000,560);
  for(int i=1;i<=13;i++){
    line(75*i,560,75*i,720);
  }
  line(0,720,1000,720);
  line(0,860,1000,860);
  line(500,720,500,1000);
  for(int i=0;i<p1.hand;i++){
    m=p1.card[i]/100;
    n=p1.card[i]%100;
    switch(m){
      case 1:
      spade(35+75*i,565,50);
      break;
      case 2:
      heart(35+75*i,615,50);
      break;
      case 3:
      diamond(35+75*i,565,60);
      break;
      case 4:
      clover(35+75*i,565,50);
      break;
    }
    if(n<10){
     text(n,75*i+20,680);      
    }
    else{
      switch(n){
       case 11:
       text("J",75*i+20,680);
       break;
       case 12:
       text("Q",75*i+20,680);
       break;
       case 13:
       text("K",75*i+20,680);
       break;
       default:
       text(n,75*i+10,680);
       break;
      }
    }
  }
  if(wn!=0){
    stroke(0,0,0);
    fill(0,0,0);
    rect(200,500,600,250);
    textFont(font,70);
    if(wn==1){
      fill(225,0,0);
      text("You win!!",250,625);
    }
    else {
    fill(0,0,225);
    text("You lose...",250,625);
    }
    textFont(font,50);
    noLoop();
  }
}

void UI(){
  fill(0,0,0);
  p1.UI();
  p2.UI();
  p3.UI();
  p4.UI();
}

class Player{
  int[] card = new int[13];
  int x,y,kill,killed,hand,pn;
  String playername;
  Player(String a,int b){
    kill=0;
    killed=0;
    hand=0;
    playername=a;
    pn=b;
    if(pn==1){
      x=0;y=0;
    }
    if(pn==2){
      x=0;y=140;
    }
    if(pn==3){
      x=500;y=0;
    }
    if(pn==4){
      x=500;y=140;
    }
  }
  void cardget(int x){
    if(hand<13){
     card[hand]=x;
    }
    hand++;
  }
  void sort(){
    Arrays.sort(card);
  }
  void UI(){
  text(playername,25+x,760+y);
  text("remain:",275+x,760+y);  
  text(hand,440+x,760+y);
  text("kill:",25+x,840+y);
  text(kill,190+x,840+y);  
  text("killed:",275+x,840+y);
  text(killed,440+x,840+y);  
  }
}

class Computer extends Player{
  int[][] can = new int[13][4];
  ArrayList<Integer> choices ;
  Computer(String x,int y){
    super(x,y);
    for(int i=0;i<13;i++){
      for(int j=0;j<4;j++){
        can[i][j]=0;
      }
    }
  }
  void choicer(){
    choices =new ArrayList<Integer>();
      for(int i=0;i<13;i++){
        for(int j=0;j<4;j++){
          if(can[i][j]+field[i][j]==3){
            choices.add((j+1)*100+(i+1));
          }
        }
      }
  }
  void play(){
    delay(750);
    choicer();
    int a,b;
    float c=random(3);
    int j=(int)c/1;
    if(choices.size()>0){
      if(st==pn){
        a=7;
        b=2;
        st=0;
      }
       else if(j<1){
         a=choices.get(0)%100;
         b=choices.get(0)/100;
       }
       else if(j<2){
         a=choices.get(choices.size()-1)%100;
         b=choices.get(choices.size()-1)/100;
       }
       else{
         a=choices.get(choices.size()/2)%100;
         b=choices.get(choices.size()/2)/100;
       }
         field[a-1][b-1]=1;
         fieldset(a-1,b-1);
         hand--;
    }
  }
}

void gamestart(){
    for(int i=0;i<13;i++){
      for(int j=0;j<4;j++){
        field[i][j]=0;
      }
    }
    for(int i=0;i<52;i++){
      float a=random(13);
      float b=random(4);
      int aa=(int)a/1;
      int bb=(int)b/1;
      while(field[aa][bb]!=0){
        a=random(13);
        b=random(4);
        aa=(int)a/1;
        bb=(int)b/1;
      }
      field[aa][bb]=1;
      int x=(bb+1)*100+(aa+1);
      if(i%4==0){
        p1.cardget(x);
      }
      else if(i%4==1){
        p2.cardget(x);
        p2.can[aa][bb]=1;
      }
      else if(i%4==2){
        p3.cardget(x);
        p3.can[aa][bb]=1;
      }
      else if(i%4==3){
        p4.cardget(x);
        p4.can[aa][bb]=1;
      }
      if(x==207){
        turn=i%4+1;
        st=turn;
      }
    }
     for(int i=0;i<13;i++){
      for(int j=0;j<4;j++){
        if(i==6){
          field[i][j]=2;
        }
        else{
         field[i][j]=0;
        }
      }
    }
    p1.sort();
    p2.sort();
    p3.sort();
    p4.sort();
}

void spade(float x,float y,float size){
 float r=size/4;
 fill(0,0,0);
 stroke(0,0,0);
 ellipse(x-((4*r)/5),y+((3*size)/5),2*r,2*r);
 ellipse(x+((4*r)/5),y+((3*size)/5),2*r,2*r);
 quad(x-2*size/5,y+9*r/5,x,y+3*r,x+2*size/5,y+9*r/5,x,y);
 rect(x-size/20,y+9*r/5,size/10,size/2);
}

void heart(float x,float y,float size){
 float r=size/4;
 fill(255,50,50);
 stroke(255,50,50);
 ellipse(x-((4*r)/5),y-((3*size)/5),2*r,2*r);
 ellipse(x+((4*r)/5),y-((3*size)/5),2*r,2*r);
 quad(x-2*size/5,y-9*r/5,x,y-3*r,x+2*size/5,y-9*r/5,x,y);
}

void diamond(float x,float y,float size){
 fill(255,50,50);
 stroke(255,50,50);
 quad(x-3*size/10,y+9*size/20,x,y+9*size/10,x+3*size/10,y+9*size/20,x,y);  
}

void clover(float x,float y,float size){
 float r=size/4;
 fill(0,0,0);
 stroke(0,0,0);
 quad(x-(r/4),y+2*r,x+(r/4),y+2*r,x+(r/2),y+(4*r),x-(r/2),y+(4*r));
 ellipse(x,y+r,2*r,2*r);
 ellipse(x-4*r/5,y+11*r/5,2*r,2*r);
 ellipse(x+4*r/5,y+11*r/5,2*r,2*r);
}

void fieldset(int n,int m){
  switch(n){
    case 0:
    if(m!=0&&m!=3){
      for(int i=-1;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n+1][m+i]==0){
          field[n+1][m+i]=2;
        }
      }
    }
    else if(m==0){
      for(int i=0;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[m+i][n+1]==0){
          field[n+1][m+i]=2;
        }
      }
    }
    else if(m==3){
      for(int i=-1;i<1;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n+1][m+i]==0){
          field[n+1][m+i]=2;
        }
      }      
    }
    break;
    case 12:
    if(m!=0&&m!=3){
      for(int i=-1;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }
      }
    }
    else if(m==0){
      for(int i=0;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }
      }
    }
    else if(m==3){
      for(int i=-1;i<1;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }
      }      
    }
    break;
    default:
    if(m!=0&&m!=3){
      for(int i=-1;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n+1][m+i]==0){
          field[n+1][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }        
      }
    }
    else if(m==0){
      for(int i=0;i<2;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n+1][m+i]==0){
          field[n+1][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }
      }
    }
    else if(m==3){
      for(int i=-1;i<1;i++){
        if(field[n][m+i]==0){
          field[n][m+i]=2;
        }
        if(field[n+1][m+i]==0){
          field[n+1][m+i]=2;
        }
        if(field[n-1][m+i]==0){
          field[n-1][m+i]=2;
        }
      }      
    }
    break;
  }
  killchecker(n,m);
}
