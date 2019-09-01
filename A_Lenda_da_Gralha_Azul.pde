import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim audio;
AudioPlayer menuSom;
AudioPlayer penaAzulSom;
AudioPlayer pessegoSom;
AudioPlayer pinhaoSom;
AudioPlayer penaPretaPegarSom;
AudioPlayer penaPretaUsarSom;
AudioPlayer buracoSom;
AudioPlayer asaSom;
AudioPlayer gritoSom;
AudioPlayer nivelSom;
AudioPlayer winSom;
AudioPlayer loseSom;
AudioPlayer tempoSom;
AudioPlayer tiroSom;
AudioPlayer endSom;

boolean winSound = true;
boolean loseSound = true;
boolean tiroSound = true;

PFont komika;

//VARIÁVEIS AQUI vv;
//Versão
String versao = "lazuli-v7.8";

//Variáveis de imagem;
PImage[] mapa = new PImage[4];
PImage[] menu = new PImage[6];
PImage[] cacador = new PImage[4];
PImage[] pessego = new PImage[3];
PImage[] penaAzul = new PImage[3];
PImage[] penaPreta = new PImage[3];
PImage[] pinhao = new PImage[2];
PImage[] spriteAtual = new PImage[5];
PImage[] comoJogarTela = new PImage[2];
PImage[] perdeuMenu = new PImage[2];
PImage[] continuar = new PImage[2];
PImage[] voltarMenu = new PImage[2];
PImage[] placar = new PImage[2];
PImage[] proximo = new PImage[2];
PImage[] voltar = new PImage[2];
PImage[] x = new PImage[2];
PImage[] iniciar = new PImage[2];
PImage pauseMenu;
PImage venceuMenu;
PImage creditos;
PImage creditosBackground;
PImage introTela;
PImage grupoLogo;
PImage menuBackground;
PImage buraco;
PImage rede;
PImage spriteGralha;
PImage spriteCacadorStun;
PImage spriteArrowsRelease;
PImage spriteCacador;
PImage gameWinBackground;
PImage gameLoseBackground;
PImage gameEndBackground;
PImage placarBackground;
PImage transparency;
PImage spriteComoJogar;

//Indica qual tela será carregada;
int gameScreen = 0;

//Matrizes dos níveis do jogo;
//Tiles 40x40; 0 = HUD; 2 = "parede"; 3 = pinhão; 4 = buraco; 5 = pêssego; 6 = pena azul; 7 = pena preta;
final float TILEWIDTH = 20;
final float TILEHEIGHT = 20;
int[][] grid = new int[15][20];
int[][] level0 = {
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  3,  1,  1,  1,  1,  1,  1,  5,  1,  1,  1,  1,  3,  1,  1,  1,  1,  3,  0  },
  {  0,  1,  2,  2,  1,  2,  1,  2,  2,  2,  1,  2,  2,  1,  2,  1,  2,  2,  1,  0  },
  {  0,  1,  2,  3,  1,  2,  1,  2,  3,  1,  7,  3,  2,  1,  2,  1,  1,  2,  6,  0  },
  {  0,  1,  2,  1,  2,  2,  1,  2,  1,  2,  2,  1,  2,  1,  2,  2,  1,  2,  1,  0  },
  {  0,  1,  1,  1,  1,  1,  1,  2,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  0  },
  {  0,  1,  2,  2,  2,  2,  1,  3,  1,  2,  2,  1,  1,  1,  2,  2,  2,  2,  1,  0  },
  {  0,  3,  1,  1,  3,  2,  3,  2,  1,  4,  2,  1,  2,  3,  2,  3,  1,  3,  1,  0  },
  {  0,  1,  2,  1,  1,  3,  6,  2,  1,  1,  1,  1,  2,  1,  3,  1,  1,  2,  1,  0  },
  {  0,  1,  2,  1,  2,  2,  1,  2,  1,  2,  2,  1,  2,  1,  2,  2,  1,  2,  1,  0  },
  {  0,  1,  2,  1,  1,  2,  1,  2,  5,  1,  1,  3,  2,  1,  2,  1,  1,  2,  1,  0  },
  {  0,  3,  2,  2,  1,  2,  1,  2,  2,  1,  2,  2,  2,  1,  2,  1,  2,  2,  1,  0  },
  {  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  7,  1,  1,  1,  1,  1,  3,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
};

int[][] level1 = {
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  1,  2,  2,  2,  2,  2,  6,  1,  1,  1,  3,  1,  1,  1,  1,  1,  1,  1,  0  },
  {  0,  1,  2,  2,  2,  2,  2,  1,  2,  2,  2,  2,  2,  2,  3,  2,  3,  2,  1,  0  },
  {  0,  3,  1,  1,  1,  3,  1,  1,  1,  3,  1,  1,  1,  1,  1,  2,  2,  2,  3,  0  },
  {  0,  1,  2,  2,  2,  2,  2,  1,  2,  2,  2,  1,  2,  2,  1,  1,  5,  1,  1,  0  },
  {  0,  1,  1,  3,  2,  3,  1,  1,  1,  3,  2,  3,  1,  1,  1,  2,  2,  2,  1,  0  },
  {  0,  1,  2,  1,  2,  1,  2,  2,  2,  1,  2,  2,  2,  2,  1,  2,  3,  1,  1,  0  },
  {  0,  1,  2,  1,  1,  1,  2,  6,  1,  3,  1,  1,  3,  2,  1,  2,  1,  2,  2,  0  },
  {  0,  1,  2,  7,  1,  1,  1,  3,  2,  1,  2,  2,  1,  1,  7,  2,  1,  2,  2,  0  },
  {  0,  1,  2,  1,  2,  1,  2,  2,  2,  1,  2,  1,  3,  2,  1,  2,  1,  2,  2,  0  },
  {  0,  1,  1,  3,  2,  1,  1,  1,  1,  1,  2,  1,  2,  2,  1,  2,  1,  2,  2,  0  },
  {  0,  1,  2,  2,  2,  2,  2,  3,  2,  2,  2,  5,  2,  1,  1,  2,  1,  2,  2,  0  },
  {  0,  3,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  3,  1,  1,  1,  4,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
};

int[][] level2 = {
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  3,  1,  1,  1,  1,  3,  2,  2,  2,  3,  1,  1,  1,  3,  1,  1,  1,  1,  0  },
  {  0,  1,  2,  2,  2,  2,  1,  2,  2,  2,  1,  2,  2,  1,  1,  1,  2,  2,  1,  0  },
  {  0,  1,  1,  1,  3,  2,  1,  6,  1,  3,  1,  1,  2,  2,  1,  2,  2,  2,  1,  0  },
  {  0,  1,  2,  2,  1,  1,  1,  2,  2,  2,  2,  7,  1,  1,  1,  1,  1,  1,  3,  0  },
  {  0,  1,  3,  2,  1,  2,  2,  2,  1,  3,  2,  2,  1,  2,  2,  2,  1,  2,  2,  0  },
  {  0,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  1,  3,  1,  1,  2,  1,  2,  5,  0  },
  {  0,  1,  2,  2,  1,  1,  5,  2,  2,  2,  1,  1,  1,  2,  1,  2,  1,  1,  1,  0  },
  {  0,  3,  1,  1,  1,  2,  2,  2,  4,  2,  2,  2,  1,  2,  3,  1,  1,  2,  3,  0  },
  {  0,  1,  2,  2,  1,  2,  2,  2,  1,  2,  2,  2,  6,  2,  2,  2,  1,  2,  2,  0  },
  {  0,  1,  2,  3,  1,  2,  2,  3,  1,  3,  2,  2,  1,  1,  1,  1,  1,  1,  2,  0  },
  {  0,  1,  2,  2,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  2,  2,  1,  1,  0  },
  {  0,  7,  1,  1,  1,  1,  3,  2,  2,  2,  3,  1,  1,  3,  2,  2,  2,  2,  3,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
};

int[][] level3 = {
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
  {  0,  1,  1,  3,  1,  1,  1,  1,  1,  1,  1,  1,  5,  2,  3,  1,  1,  1,  3,  0  },
  {  0,  1,  2,  2,  2,  1,  2,  1,  2,  1,  2,  2,  1,  2,  2,  2,  1,  2,  2,  0  },
  {  0,  6,  1,  1,  2,  1,  2,  3,  2,  1,  3,  2,  1,  1,  1,  1,  1,  2,  2,  0  },
  {  0,  1,  2,  3,  1,  1,  2,  1,  2,  2,  1,  2,  2,  1,  2,  3,  1,  2,  2,  0  },
  {  0,  1,  2,  2,  2,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  1,  2,  2,  0  },
  {  0,  1,  1,  1,  1,  1,  1,  2,  3,  2,  2,  3,  2,  1,  7,  1,  1,  1,  3,  0  },
  {  0,  2,  2,  2,  2,  2,  2,  2,  1,  2,  2,  1,  2,  2,  2,  2,  2,  2,  2,  0  },
  {  0,  3,  1,  2,  2,  2,  5,  1,  1,  1,  1,  1,  1,  6,  1,  1,  1,  1,  1,  0  },
  {  0,  1,  1,  3,  2,  3,  2,  1,  2,  1,  2,  1,  2,  2,  2,  1,  2,  2,  1,  0  },
  {  0,  1,  2,  1,  1,  1,  2,  1,  3,  1,  2,  7,  2,  3,  2,  1,  2,  2,  3,  0  },
  {  0,  1,  2,  2,  4,  2,  2,  1,  2,  1,  2,  2,  2,  1,  2,  1,  2,  2,  2,  0  },
  {  0,  3,  1,  1,  1,  1,  1,  1,  1,  3,  1,  1,  1,  1,  1,  1,  1,  1,  3,  0  },
  {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0  },
};


//Timers;
int[] timer = new int[21];

//Variáveis de direção/teclas;
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
boolean arrowLeft = false;
boolean arrowRight = false;
boolean space = false;
boolean enter = false;
boolean p = false;
int d;

//Variáveis referente a Gralha (ex. posição);
int gX;                //Posição X da Gralha;
int gY;                //Posição Y da Gralha;
float gvX;
float gvY;
float gV;               //Velocidade da Gralha;
String gD = "down";        //Direção da Gralha;

//Variáveis referente aos Caçadores;
int[] cX = new int[2];                           //Posição X dos Caçadores;
int[] cY = new int[2];                           //Posição Y dos Caçadores;
float[] cvX = new float[2];
float[] cvY = new float[2];
float cV;                                    //Velocidade dos Caçadores;
String[] cD = {  "down",  "down"  };            //Direção do Caçador; [0]Caçador1; [1]Caçador2;
int[] timerC = new int[2];  //Timer da movimentação do Caçador;
int[] cmD = new int[2];

//Variáveis Animação;
int[] ssX = new int[6];

//Variáveis referente a Rede;
int[] rX = new int[2];
int[] rY = new int[2];
String rD = "";
int[] atirar = {  0, 0  };
boolean preso = false;
int presoCount = 50;
int rV = 6;

//Variáveis refente ao Pinhão e Buraco;
int[] nPinhao = new int[4];        //Quantidade de Pinhão coletado;
int[] nPinhaoLevel = new int[4];   //Quantidade de Pinhão no level;
int[] nBuraco = new int[4];        //Quantidade de Pinhão no Buraco;
int qPinhao;

//Variáveis referente ao Score;
int[] score = new int[4];
int[] scorePU = new int[4];
int[] scoreFinal = new int[4];
int[] scoreTempo = new int[4];
int[] highScore = new int[50];
int highScoreAtual;

//Variáveis dos Power-Up's;
boolean ativPessego = false;
boolean ativPenaAzul = false;
boolean ativPenaPreta = false;
int nPenaPreta;

//Variáveis referente ao level;
int gameLevel = 0;
int newGame = 0;
boolean venceu = false;
boolean perdeu = false;

//Variáveis referente as telas;
int nTelaComoJogar = 0;
int creditosX = 120;
int creditosY = 600;
boolean pause = false;

//Variáveis refente ao tempo do mapa;
int[] t = new int[4];

int alpha;

int nWin;


//SETUP AQUI vv;
void setup() {
  size(800, 600);      //Tamanho da tela;
  
  nPinhaoLevel();
  
  //Carregar as imagens nas variáveis;
  grupoLogo = loadImage("logoplaceholder.png");
  menuBackground = loadImage("menuBackground.png");
  menu[0] = loadImage("comecar1.png");
  menu[1] = loadImage("comecar2.png");
  menu[2] = loadImage("como_jogar1.png");
  menu[3] = loadImage("como_jogar2.png");
  menu[4] = loadImage("creditos1.png");
  menu[5] = loadImage("creditos2.png");
  mapa[0] = loadImage("mapa0.png");
  mapa[1] = loadImage("mapa1.png");
  mapa[2] = loadImage("mapa2.png");
  mapa[3] = loadImage("mapa3.png");
  cacador[0] = loadImage("c1.png");
  cacador[1] = loadImage("c2.png");
  cacador[2] = loadImage("c3.png");
  cacador[3] = loadImage("c4.png");
  spriteGralha = loadImage("sprite_gralha.png");
  pessego[0] = loadImage("pessego.png");
  pessego[1] = loadImage("pessego_hud.png");
  pessego[2] = loadImage("pessego_efeito_hud.png");
  penaAzul[0] = loadImage("pena_azul.png");
  penaAzul[1] = loadImage("pena_azul_hud.png");
  penaAzul[2] = loadImage("pena_azul_efeito_hud.png");
  penaPreta[0] = loadImage("pena_preta.png");
  penaPreta[1] = loadImage("pena_preta_hud.png");
  penaPreta[2] = loadImage("pena_preta_efeito_hud.png");
  pinhao[0] = loadImage("pinhao.png");
  pinhao[1] = loadImage("pinhao_hud.png");
  buraco = loadImage("buraco.png");
  gameWinBackground = loadImage("game_win_background.png");
  gameLoseBackground = loadImage("game_lose_background.png");
  spriteCacadorStun = loadImage("sprite_cacador_stun.png");
  rede = loadImage("rede.png");
  spriteArrowsRelease = loadImage("sprite_setinhas.png");
  comoJogarTela[0] = loadImage("como_jogar_tela0.png");
  comoJogarTela[1] = loadImage("como_jogar_tela1.png");
  introTela = loadImage("intro.png");
  creditos = loadImage("creditos.png");
  creditosBackground = loadImage("creditos_background.png");
  spriteCacador = loadImage("sprite_cacador.png");
  pauseMenu = loadImage("pause.png");
  venceuMenu = loadImage("venceu.png");
  perdeuMenu[0] = loadImage("perdeu1.png");
  perdeuMenu[1] = loadImage("perdeu2.png");
  gameEndBackground = loadImage("game_end_background.png");
  placarBackground = loadImage("placar_background.png");
  transparency = loadImage("transparency.png");
  continuar[0] = loadImage("continuar1.png");
  continuar[1] = loadImage("continuar2.png");
  voltarMenu[0] = loadImage("voltar_menu1.png");
  voltarMenu[1] = loadImage("voltar_menu2.png");
  placar[0] = loadImage("placar1.png");
  placar[1] = loadImage("placar2.png");
  proximo[0] = loadImage("proximo1.png");
  proximo[1] = loadImage("proximo2.png");
  voltar[0] = loadImage("voltar1.png");
  voltar[1] = loadImage("voltar2.png");
  x[0] = loadImage("x1.png");
  x[1] = loadImage("x2.png");
  spriteComoJogar = loadImage("sprite_como_jogar.png");
  iniciar[0] = loadImage("iniciar1.png");
  iniciar[1] = loadImage("iniciar2.png");
  
  audio = new Minim(this);
  menuSom = audio.loadFile("sons/menu2.wav");
  pinhaoSom = audio.loadFile("sons/pinhao.wav");
  penaAzulSom = audio.loadFile("sons/pena_azul.wav");
  pessegoSom = audio.loadFile("sons/pessego.wav");
  penaPretaPegarSom = audio.loadFile("sons/pena_preta_pegar.wav");
  penaPretaUsarSom = audio.loadFile("sons/pena_preta_usar.wav");
  buracoSom = audio.loadFile("sons/buraco.mp3");
  asaSom = audio.loadFile("sons/asas2.wav");
  gritoSom = audio.loadFile("sons/gralha_grito.wav");
  nivelSom = audio.loadFile("sons/jogo.wav");
  winSom = audio.loadFile("sons/win.wav");
  loseSom = audio.loadFile("sons/lose.wav");
  tempoSom = audio.loadFile("sons/tempo.wav");
  tiroSom = audio.loadFile("sons/tiro.wav");
  endSom = audio.loadFile("sons/end.wav");
  
  komika = loadFont("KomikaText-48.vlw");
  textFont(komika);
  fill(255,255,255);
}

//DRAW AQUI vv;
void draw() {
  if (gameScreen == 0) devScreen();
  if (gameScreen == 1) initScreen();
  if (gameScreen == 2) instrScreen();
  if (gameScreen == 3) creditosScreen();
  if (gameScreen == 4) gameScreen0();
  if (gameScreen == 5) gameScreen1();
  if (gameScreen == 6) gameScreen2();
  if (gameScreen == 7) gameWinScreen();
  if (gameScreen == 8) gameOverScreen();
  if (gameScreen == 9) introScreen();
  if (gameScreen == 10) gameEndScreen();
  if (gameScreen == 11) highScoreScreen();
  if (gameScreen == 12) gameScreen3();
}

//TELAS DO JOGO AQUI vv;
//Tela como o logo do grupo;
void devScreen() { 
  tint(255, alpha);
  background(0);
  image(grupoLogo, 200, 160);
  timer[0]++;
  if (timer[0] < 150) alpha += 10;
  else alpha -= 10;
  if (timer[0] >= 300 || enter) {
    timer[0] = 0;
    tint(255, 255);
    gameScreen = 1;
  }
}

//Tela inicial do jogo, com o menu;
void initScreen() {
  nPenaPreta = 0;
  tiroSound = true;
  winSound = true;
  loseSound = true;
  nivelSom.pause();
  if (menuSom.isPlaying() != true) menuSom.loop(0);
  image(menuBackground, 0, 0);
  if ((mouseX > 283 && mouseX < 516) && (mouseY > 320 && mouseY < 375)) {
   image(menu[1], 283, 320);                //Botão Iniciar;
  } else image(menu[0], 283, 320);
  if ((mouseX > 283 && mouseX < 516) && (mouseY > 395 && mouseY < 450)) {
   image(menu[3], 283, 395);                //Botão Como Jogar;
  } else image(menu[2], 283, 395);
  if ((mouseX > 318 && mouseX < 482) && (mouseY > 465 && mouseY < 525)) {
   image(menu[5], 318, 465);                 //Botão Créditos;
  } else image(menu[4], 318, 465);
  if ((mouseX > 340 && mouseX < 460) && (mouseY > 534 && mouseY < 584)) {
   image(placar[1], 340, 534);                 //Botão Placar;
  } else image(placar[0], 340, 534);
  for (int i = 0; i < 4; i++) {
     score[i] = 0;
     scoreTempo[i] = 0;
     scoreFinal[i] = 0;
     scorePU[i] = 0;
    }
  creditosY = 600;
  prepLevel();
}

//Tela de intro inicial;
void introScreen() {
  image(introTela, 0, 0);
  if ((mouseX > 269 && mouseX < 560) && (mouseY > 430 && mouseY < 521)) {
    image(iniciar[1], 269, 430);
  } else image(iniciar[0], 269, 430);
  if (enter) {
    menuSom.pause();
    startGame();
  }
}

//Tela com as instruções de como jogar;
void instrScreen() {
  
  if (nTelaComoJogar == 0) {
   image(comoJogarTela[0], 0, 0);
   image(animaComoJogar(spriteComoJogar), 645, 131);
   if ((mouseX > 647 && mouseX < 787) && (mouseY > 555 && mouseY < 595)) {
    image(proximo[1], 647, 555); 
   } else image(proximo[0], 647, 555);
  }
  if (nTelaComoJogar == 1) {
   image(comoJogarTela[1], 0, 0);
   if ((mouseX > 14 && mouseX < 119) && (mouseY > 555 && mouseY < 595)) {
     image(voltar[1], 14, 555);
   } else image(voltar[0], 14, 555);
  }
  if ((mouseX > 732 && mouseX < 767) && (mouseY > 20 && mouseY < 65)) {
    image(x[1], 732, 20);
  } else image(x[0], 732, 20);
}

//Tela de créditos com nome e RA dos integrantes do grupo e outras infos;
void creditosScreen() {
  timer[20]++;
  menuSom.pause();
  if (endSom.isPlaying() != true) endSom.loop();
  image(creditosBackground, 0, 0);
  image(creditos, creditosX, creditosY);
  if (creditosY == -520) creditosY += 0;
  else creditosY--;
  if (enter && timer[20] > 60) {
    timer[20] = 0;
    endSom.pause();
    gameScreen = 1;
  }
}

//Telas dos níveis do jogo;
void gameScreen0() {
  if (venceu || perdeu || pause) {
    nivelSom.pause();
  } else if (nivelSom.isPlaying() != true) nivelSom.loop(0);
  gameWin(gameLevel);
  if (venceu) {
    if (venceu && winSound) {
      winSom.play(0);
      winSound = false;
    }
    asaSom.pause();
    return;
  }
  gameLose(gameLevel);
  if (perdeu) {
    if (perdeu && loseSound) {
     loseSom.play(0);
     loseSound = false;
    }
    asaSom.pause();
    gritoSom.pause();
    return;
  }
  gamePause();
  if (pause) {
    asaSom.pause();
    return;
  }
  image(mapa[0], 0, 0);
  hud(gameLevel);
  score();
  itens();
  gralha();
  atirarRede();
  release();
  cacador();
  powerUps();
}

void gameScreen1() {
  if (venceu || perdeu || pause) {
    nivelSom.pause();
  } else if (nivelSom.isPlaying() != true) nivelSom.loop(0);
  gameWin(gameLevel);
  if (venceu) {
    if (venceu && winSound) {
      winSom.play(0);
      winSound = false;
    }
    asaSom.pause();
    return;
  }
  gameLose(gameLevel);
  if (perdeu) {
    if (perdeu && loseSound) {
     loseSom.play(0);
     loseSound = false;
    }
    asaSom.pause();
    gritoSom.pause();
    return;
  }
  gamePause();
  if (pause) {
    asaSom.pause();
    return;
  }
  image(mapa[1], 0, 0);
  hud(gameLevel);
  score();
  itens();
  gralha();
  atirarRede();
  release();
  cacador();
  powerUps();
}

void gameScreen2() {
  if (venceu || perdeu || pause) {
    nivelSom.pause();
  } else if (nivelSom.isPlaying() != true) nivelSom.loop(0);
  gameWin(gameLevel);
  if (venceu) {
    if (venceu && winSound) {
      winSom.play(0);
      winSound = false;
    }
    asaSom.pause();
    return;
  }
  gameLose(gameLevel);
  if (perdeu) {
    if (perdeu && loseSound) {
     loseSom.play(0);
     loseSound = false;
    }
    asaSom.pause();
    gritoSom.pause();
    return;
  }
  gamePause();
  if (pause) {
    asaSom.pause();
    return;
  }
  image(mapa[2], 0, 0);
  hud(gameLevel);
  score();
  itens();
  gralha();
  atirarRede();
  release();
  cacador();
  powerUps();
}

void gameScreen3() {
  if (venceu || perdeu || pause) {
    nivelSom.pause();
  } else if (nivelSom.isPlaying() != true) nivelSom.loop(0);
  gameWin(gameLevel);
  if (venceu) {
    if (venceu && winSound) {
      winSom.play(0);
      winSound = false;
    }
    asaSom.pause();
    return;
  }
  gameLose(gameLevel);
  if (perdeu) {
    if (perdeu && loseSound) {
     loseSom.play(0);
     loseSound = false;
    }
    asaSom.pause();
    gritoSom.pause();
    return;
  }
  gamePause();
  if (pause) {
    asaSom.pause();
    return;
  }
  image(mapa[3], 0, 0);
  hud(gameLevel);
  score();
  itens();
  gralha();
  atirarRede();
  release();
  cacador();
  powerUps();
}

//Tela de vitória com a pontuação e curiosidades;
void gameWinScreen() {
  asaSom.pause();
  tiroSound = true;
  winSound = true;
  loseSound = true;
  image(gameWinBackground, 0, 0);
  textAlign (CENTER);
  fill(255,255,255);
  textSize (28);
  text ("Pontuação: " + score[gameLevel], width/2, 200);
  text ("Bônus de Tempo: " + scoreTempo[gameLevel], width/2, 250);
  textSize (36);
  text ("Sua Pontuação Final é: " + scoreFinal[gameLevel], width/2, height/2);
  textSize(16);
  textAlign(CENTER);
  text("Pressione ENTER para continuar", width/2, 340);
  highScore[newGame -1] = scoreFinal[gameLevel];
  timer[14]++;
  if (enter && timer[14] >= 60) {
    gameLevel++;
    prepLevel();
    if (gameLevel == 1) gameScreen = 5;
    if (gameLevel == 2) gameScreen = 6;
    if (gameLevel == 3) gameScreen = 12;
  }
}

//Tela de derrota com a pontuação e curiosidades;
void gameOverScreen() {
  pause = false;
  asaSom.pause();
  tiroSound = true;
  winSound = true;
  loseSound = true;
  image(gameLoseBackground, 0, 0);
  textAlign (CENTER);
  fill(255,255,255);
  textSize (28);
  text ("Pontuação: " + score[gameLevel], width/2, 200);
  text ("Bônus de Tempo do Nível: " + 0, width/2, 250);
  textSize (36);
  text ("Sua Pontuação Final é: " + score[gameLevel], width/2, height/2);
  textSize(16);
  textAlign(CENTER);
  text("Pressione ENTER para continuar", width/2, 340);
  highScore[newGame -1] = score[gameLevel];
  timer[15]++;
  if (enter && timer[15] >= 60) {
    for (int i = 0; i < 4; i++) {
     score[i] = 0;
     scoreTempo[i] = 0;
     scoreFinal[i] = 0;
     scorePU[i] = 0;
    }
    gameLevel = 0;
    gameScreen = 11;
  }
}
void gameEndScreen() {
  asaSom.pause();
  tiroSound = true;
  winSound = true;
  loseSound = true;
  image(gameEndBackground, 0, 0);
  fill(255,255,255);
  textAlign (CENTER);
  textSize (28);
  text ("Pontuação: " + score[gameLevel], width/2, 200);
  text ("Bônus de Tempo: " + scoreTempo[gameLevel], width/2, 250);
  textSize (36);
  text ("Sua Pontuação Final é: " + scoreFinal[gameLevel], width/2, height/2);
  textSize(16);
  textAlign(CENTER);
  text("Pressione ENTER para continuar", width/2, 340);
  highScore[newGame -1] = scoreFinal[gameLevel];
  timer[14]++;
  if (enter && timer[14] >= 60) {
     gameLevel = 0;
     gameScreen = 11; 
   }
}
void highScoreScreen() {
  tiroSound = true;
  winSound = true;
  loseSound = true;
  menuSom.pause();
  if (endSom.isPlaying() != true) endSom.loop();
  image(placarBackground, 0, 0);
  textAlign(CENTER);
  fill(255,255,255);
  textSize(36);
  ordenar();
  text("1 . " + highScore[0] + " pts", width/2, 150);
  text("2 . " + highScore[1] + " pts", width/2, 190);
  text("3 . " + highScore[2] + " pts", width/2, 230);
  text("4 . " + highScore[3] + " pts", width/2, 270);
  text("5 . " + highScore[4] + " pts", width/2, 310);
  text("6 . " + highScore[5] + " pts", width/2, 350);
  text("7 . " + highScore[6] + " pts", width/2, 390);
  text("8 . " + highScore[7] + " pts", width/2, 430);
  text("9 . " + highScore[8] + " pts", width/2, 470);
  text("10. " + highScore[9] + " pts", width/2, 510);
  timer[16]++;
  if (enter && timer[16] >= 60) {
   if (nWin == 1) {
      gameLevel = 0;
      nWin++;
      gameScreen = 3;
     } else {
       endSom.pause();
       gameLevel = 0;
       gameScreen = 1;
     }
  }
}
//INPUTS AQUI vv;
public void keyPressed() {
  if (keyCode == UP) up = true;
  else if (keyCode == DOWN) down = true;
  else if (keyCode == LEFT) left = true;
  else if (keyCode == RIGHT) right = true;
  if (keyCode == ENTER) enter = true;
  if (keyCode == LEFT) arrowLeft = true;
  if (keyCode == RIGHT) arrowRight = true;
  if (keyCode == 32) space = true;
  if (keyCode == 80) p = true;
}
public void keyReleased() {
  if (keyCode == UP) up = false;
  else if (keyCode == DOWN) down = false;
  else if (keyCode == LEFT) left = false;
  else if (keyCode == RIGHT) right = false;
  if (keyCode == ENTER) enter = false;
  if (keyCode == LEFT) arrowLeft = false;
  if (keyCode == RIGHT) arrowRight = false;
  if (keyCode == 32) space = false;
  if (keyCode == 80) p = false;
}
public void mousePressed() {
 if (gameScreen == 1) {
  if ((mouseX > 283 && mouseX < 516) && (mouseY > 320 && mouseY < 375)) {
    newGame++;
    if (newGame == 1) {
      gameScreen = 9; 
    } else {
      menuSom.pause();
      gameScreen = 4;
    }
  }
  if ((mouseX > 283 && mouseX < 516) && (mouseY > 400 && mouseY < 455)) gameScreen = 2;
  if ((mouseX > 318 && mouseX < 482) && (mouseY > 480 && mouseY < 535)) gameScreen = 3;
  if ((mouseX > 340 && mouseX < 460) && (mouseY > 534 && mouseY < 584)) gameScreen = 11; 
 }
 if (gameScreen == 2 && nTelaComoJogar == 0) {
   if ((mouseX > 732 && mouseX < 767) && (mouseY > 20 && mouseY < 65)) {
     nTelaComoJogar = 0;
     gameScreen = 1;
   }
   if ((mouseX > 647 && mouseX < 787) && (mouseY > 555 && mouseY < 595)) nTelaComoJogar = 1;
   //if ((mouseX > 14 && mouseX < 119) && (mouseY > 540 && mouseY < 590)) gameScreen = 1; 
 }
 if (gameScreen == 2 && nTelaComoJogar == 1) {
   if ((mouseX > 732 && mouseX < 767) && (mouseY > 20 && mouseY < 65)){
     nTelaComoJogar = 0;
     gameScreen = 1;
   }
   if ((mouseX > 14 && mouseX < 119) && (mouseY > 540 && mouseY < 590)) nTelaComoJogar = 0;
 }
 if (gameScreen == 9) {
   if ((mouseX > 269 && mouseX < 560) && (mouseY > 430 && mouseY < 521) && mousePressed) {
     menuSom.pause();
     startGame();
   }
 }
 if ((gameScreen == 4 || gameScreen == 5 || gameScreen == 6 || gameScreen == 12 ) && pause) {
  if (((mouseX > 278 && mouseX < 522) && (mouseY > 336 && mouseY < 372))  || (timer[17] >= 30 && enter)) {
     timer[18] = 0;
     timer[17] = 0;
     pause = false;
   }
   if ((mouseX > 290 && mouseX < 505) && (mouseY > 240 && mouseY < 275)) {
     pause = false;
     gameScreen = 1;
 } 
 }
}
//OUTRAS FUNÇÕES AQUI vv;
//Função para iniciar o jogo (remover?);
void startGame() {
 gameScreen = 4; 
}

//Função que desenha a gralha;
void gralha() {
  if (asaSom.isPlaying() != true) asaSom.loop();
  coletaItens(gameLevel);
  direcao();
  if (d == 1) {
   moveGralha(gX, gY + 1, 0, +gV);
   gD = "down"; 
  } else if (d == 2) {
   moveGralha(gX, gY - 1, 0, -gV);
   gD = "up"; 
  } else if (d == 3) {
   moveGralha(gX - 1, gY, -gV, 0);
   gD = "left"; 
  } else if (d == 4) {
   moveGralha(gX + 1, gY, +gV, 0);
   gD = "right"; 
  }
  if (preso) {
    if (gritoSom.isPlaying() != true) gritoSom.loop();
    if (preso != true) gritoSom.pause();
    image(animaGralha(spriteGralha, 0), gvX * 40, gvY * 40);
  } else {
    if (gD == "down") image(animaGralha(spriteGralha, 0), gvX * 40, gvY * 40);
    else if (gD == "up") image(animaGralha(spriteGralha, 40), gvX * 40, gvY * 40);
    else if (gD == "left") image(animaGralha(spriteGralha, 120), gvX * 40, gvY * 40);
    else if (gD == "right") image(animaGralha(spriteGralha, 80), gvX * 40, gvY * 40);
  }
}
//Função de movimentação da gralha;
void moveGralha(int nX, int nY, float vX, float vY) {
  int tile = grid[nY][nX];
  if (tile == 0 || tile == 2 || preso) return;
  timer[1]++;
  gvX += vX;
  gvY += vY;
  if (timer[1] >= 10) {
    gX = nX;
    gY = nY;
    timer[1] = 0;
  }
  if (timer[1] >= 5 && ativPenaAzul) {
   gX = nX;
   gY = nY;
   timer[1] = 0;
  }
}
//Função de direção para movimentação da gralha;
void direcao() {
 if (down && timer[1] == 0) d = 1;
 if (up && timer[1] == 0) d = 2;
 if (left && timer[1] == 0) d = 3;
 if (right && timer[1] == 0) d = 4;
}
void coletaItens(int i) {
 if (grid[gY][gX] == 3) {
  pinhaoSom.play(0);
  grid[gY][gX] = 1;
  nPinhao[i]++;
  qPinhao++;
  score[i] += 50;
 }
 if (grid[gY][gX] == 4) {
  if (qPinhao > 0) buracoSom.play(0);
  nBuraco[i] = nPinhao[i];
  qPinhao = 0;
 } else timer[17] = 0;
 if (grid[gY][gX] == 5) {
  pessegoSom.play(0);
  grid[gY][gX] = 1;
  ativPessego = true;
  timer[4] = 0;
  scorePU[i] += 1000;
  
 }
 if (grid[gY][gX] == 6) {
  penaAzulSom.play(100);
  grid[gY][gX] = 1;
  ativPenaAzul = true;
  timer[5] = 0;
  scorePU[i] += 1000;
  
 }
 if (grid[gY][gX] == 7) {
  penaPretaPegarSom.play(100);
  grid[gY][gX] = 1;
  nPenaPreta++;
  scorePU[i] += 1000;
  
 }
}

//Função que desenha os Caçadores;
void cacador() { 
   for (int i = 0; i < 2; i++) {
   if (ativPessego) {
       image(animaCacadorStun(spriteCacadorStun), cvX[i] * 40, cvY[i] * 40);
   } else {
      if ((gX > cX[i]) && (gY < cY[i]) && timerC[i] == 0) {
        if (cmD[i] == 4) cmD[i] = 2;
        else cmD[i] = 4;
      } else if (gX < cX[i] && (gY < cY[i]) && timerC[i] == 0) {
        if (cmD[i] == 3) cmD[i] = 2;
        else cmD[i] = 3;
      } else if ((gX > cX[i]) && (gY > cY[i]) && timerC[i] == 0) {
        if (cmD[i] == 4) cmD[i] = 1;
        else cmD[i] = 4;
      } else if ((gX < cX[i]) && (gY > cY[i]) && timerC[i] == 0) {
        if (cmD[i] == 3) cmD[i] = 1;
        else cmD[i] = 3;
      } else if (gX > cX[i] && gY == cY[i] && timerC[i] == 0) cmD[i] = 4;
      else if (gX < cX[i] && gY == cY[i] && timerC[i] == 0) cmD[i] = 3;
      else if (gY > cY[i] && gX == cX[i] && timerC[i] == 0) cmD[i] = 1;
      else if (gY < cY[i] && gX == cX[i] && timerC[i] == 0) cmD[i] = 2;
     if (cmD[i] == 1) moveCacador(cX[i], cY[i] + 1, 0, +cV, i);
     else if (cmD[i] == 2) moveCacador(cX[i], cY[i] - 1, 0, -cV, i);
     else if (cmD[i] == 3) moveCacador(cX[i] - 1, cY[i], -cV, 0, i); 
     else if (cmD[i] == 4) moveCacador(cX[i] + 1, cY[i], +cV, 0, i);
     if (cD[i] == "down") image(animaCacador(spriteCacador, 0, i), cvX[i] * 40, cvY[i] * 40);
     else if (cD[i] == "up") image(animaCacador(spriteCacador, 120, i), cvX[i] * 40, cvY[i] * 40);
     else if (cD[i] == "left") image(animaCacador(spriteCacador, 40, i), cvX[i] * 40, cvY[i] * 40);
     else if (cD[i] == "right") image(animaCacador(spriteCacador, 80, i), cvX[i] * 40, cvY[i] * 40); 
     //else if (cD[i] == "parado") image(cacador[3], cvX[i] * 40, cvY[i] * 40);
    }
  }
}
//Função de movimentação do caçador;
void moveCacador(int nX, int nY, float vX, float vY, int i) {
 int tile = grid[nY][nX];
 if ((tile == 0 || tile == 2) || ativPessego) {
   //cD[i] = "parado";
   return;
 }
 if (cmD[i] == 1) cD[i] = "down";
 else if (cmD[i] == 2) cD[i] = "up";
 else if (cmD[i] == 3) cD[i] = "left";
 else if (cmD[i] == 4) cD[i] = "right";
 timerC[i]++;
 cvX[i] += vX;
 cvY[i] += vY;
 if (timerC[i] >= 50) {
  cX[i] = nX;
  cY[i] = nY;
  timerC[i] = 0;
 }
}
boolean obstaculoCacador1 (int nX, int nY, int gY) {      //Verifica colisão down;
 int tile;
 for (int i = 1; i <= (gY - nY); i++) {
   tile = grid[nY + i][nX];
   if (tile == 0 || tile == 2) return true;
 }
 return false;
}
boolean obstaculoCacador2 (int nX, int nY, int gY) {      //Verifica colisão up;
 int tile;
 for (int i = 1; i <= (nY - gY); i++) {
   tile = grid[nY - i][nX];
   if (tile == 0 || tile == 2) return true;
 }
 return false;
}
boolean obstaculoCacador3 (int nX, int nY, int gX) {      //Verifica colisão left;
 int tile;
 for (int i = 1; i <= (nX - gX); i++) {
   tile = grid[nY][nX - i];
   if (tile == 0 || tile == 2) return true;
 }
 return false;
}
boolean obstaculoCacador4 (int nX, int nY, int gX) {      //Verifica colisão right;
 int tile;
 for (int i = 1; i <= (gX - nX); i++) {
   tile = grid[nY][nX + i];
   if (tile == 0 || tile == 2) return true;
 }
 return false;
}
//Função para verificar se a Gralha está no campo de visão do Caçador;
boolean visaoCacador(int a, int b, int c, int d) {
  if (a - b <= 5 && a - b > 0 && c == d) return true;
  else return false;
}

//Função geral da rede;
void rede(int n, int n2) {
  //if (ativPessego) return;
  if (atirar[n] == 0) {
   rX[n] = cX[n] * 40;
   rY[n] = cY[n] * 40;
   if (atirar[n2] == 0 && ativPessego != true) {
  if (visaoCacador(gX, cX[n], gY, cY[n]) && obstaculoCacador4(cX[n], cY[n], gX) != true && timerC[n] == 0) atirar[n] = 4;
  if (visaoCacador(cX[n], gX, gY, cY[n]) && obstaculoCacador3(cX[n], cY[n], gX) != true && timerC[n] == 0) atirar[n] = 3;
  if (visaoCacador(gY, cY[n], gX, cX[n]) && obstaculoCacador1(cX[n], cY[n], gY) != true && timerC[n] == 0) atirar[n] = 1;
  if (visaoCacador(cY[n], gY, gX, cX[n]) && obstaculoCacador2(cX[n], cY[n], gY) != true && timerC[n] == 0) atirar[n] = 2;
  } 
  } else {
  if (presoCount <= 10) return;
  else image(rede, rX[n], rY[n]);
  if (preso) return;
  
    if (atirar[n] == 2 && atirar[n2] == 0) moveRede(0, -rV, n);
    if (atirar[n] == 1 && atirar[n2] == 0) moveRede(0, +rV, n);
    if (atirar[n] == 3 && atirar[n2] == 0) moveRede(-rV, 0, n);
    if (atirar[n] == 4 && atirar[n2] == 0) moveRede(+rV, 0, n);
  
  if (colisaoRede((gvX * 40) + 10, (gvY * 40) + 10, TILEWIDTH, TILEHEIGHT, rX[n] + 10, rY[n] + 10, TILEWIDTH, TILEHEIGHT) && ativPessego != true) {
    rX[n] = int(gvX * 40);
    rY[n] = int(gvY * 40);
    preso = true;
   }
  }
}
void moveRede(int vX, int vY, int n) {
  int y = rY[n]/40;
  int x = rX[n]/40;
  int tile = grid[y][x];
  if (tile == 0 || tile == 2) {
   atirar[n] = 0;
   timer[10] = 0;
   return; 
  }
  rX[n] += vX;
  rY[n] += vY;
}
//Função para soltar a rede;
void release() {
 if (preso) {
  image(animaArrowsRelease(spriteArrowsRelease), gvX * 40, (gvY - 0.2) * 40); 
 }
 if (preso && space && nPenaPreta > 0) {
  penaPretaUsarSom.play(0);
  gritoSom.pause();
  preso = false;
  atirar[0] = 0;
  atirar[1] = 0;
  timer[10] = 0;
  nPenaPreta--;
  for (int i = 0; i < 2; i++) {
     rX[i] = cX[i];
     rY[i] = cY[i];
   }
 }
 if ((arrowLeft || arrowRight) && preso) {
   presoCount--;
   if (presoCount <= 0) {
    gritoSom.pause();
    presoCount = 50;
    preso = false;
    atirar[0] = 0;
    atirar[1] = 0;
    timer[10] = 0;
    for (int i = 0; i < 2; i++) {
     rX[i] = cX[i];
     rY[i] = cY[i];
    }
   }
  } 
}
void atirarRede() {
  if ((atirar[0] != 0 || atirar[1] != 0) && (timerC[0] == 0 || timerC[1] == 0) && tiroSound) {
   tiroSom.play(0);
   tiroSound = false;
  }
  if (atirar[0] == 0 && atirar[1] == 0) {
    tiroSound = true;
  }
  if (atirar[0] == 0 || atirar[1] == 0) {
   timer[10]++; 
  } if (timer[10] >= 180) {
   rede(0, 1);
   rede(1, 0);
  }
}

//COLISÃO AQUI vv;
boolean colisao(float x1, float y1, float l1, float a1, float x2, float y2, float l2, float a2) {
 if (x1 + l1 < x2 || x2 + l2 < x1) return false;
 else if (y1 + a1 < y2 || y2 + a2 < y1) return false;
 else return true;
}
boolean colisaoRede(float x1, float y1, float l1, float a1, int x2, int y2, float l2, float a2) {
 if (x1 + l1 < x2 || x2 + l2 < x1) return false;
 else if (y1 + a1 < y2 || y2 + a2 < y1) return false;
 else return true;
}

//ANIMAÇÃO AQUI vv;
PImage animaGralha(PImage spriteSheet, int ssY) {
  if (spriteAtual[0] != spriteSheet) {
   spriteAtual[0] = spriteSheet;
   ssX[0] = 0;
   timer[3] = 0;
  }
  PImage sprite = spriteSheet.get(ssX[0] * 40, ssY, 40, 40);
  timer[3]++;
  if (timer[3] > 4) {
   timer[3] = 0;
   ssX[0]++;
   if (ssX[0] * 40 >= spriteSheet.width) ssX[0] = 0;
  }
  return sprite;
}
PImage animaCacador(PImage spriteSheet, int ssY, int i) {
 if (spriteAtual[2 + i] != spriteSheet) {
  spriteAtual[2 + i] = spriteSheet;
  ssX[3 + i] = 0;
  timer[11 + i] = 0;
 }
 PImage sprite = spriteSheet.get(ssX[3] * 40, ssY, 40, 40);
 timer[11 + i]++;
 if (timer[11 + i] > 12) {
  timer[11 + i] = 0;
  ssX[3 + i]++;
  if (ssX[3 + i] * 40 >= spriteSheet.width) ssX[3 + i] = 0;
 }
 return sprite;
}
PImage animaCacadorStun(PImage spriteSheet) {
  if (spriteAtual[1] != spriteSheet) {
   spriteAtual[1] = spriteSheet;
   ssX[1] = 0;
   timer[6] = 0;
  }
  PImage sprite = spriteSheet.get(ssX[1] * 40, 0, 40, 40);
  timer[6]++;
  if (timer[6] > 24) {
   timer[6] = 0;
   ssX[1]++;
   if (ssX[1] * 40 >= spriteSheet.width) ssX[1] = 0;
  }
  return sprite;
}
PImage animaArrowsRelease(PImage spriteSheet) {
 PImage sprite = spriteSheet.get(ssX[2] * 40, 0, 40, 9);
 timer[9]++;
 if (timer[9] > 10) {
  timer[9] = 0;
  ssX[2]++;
  if (ssX[2] * 40 >= spriteSheet.width) ssX[2] = 0;
 }
 return sprite;
}
PImage animaComoJogar(PImage spriteSheet) {
 PImage sprite = spriteSheet.get(ssX[3] * 129, 0, 129, 170);
 timer[19]++;
 if (timer[19] > 40) {
  timer[19] = 0;
  ssX[3]++;
  if (ssX[3] * 129 >= spriteSheet.width) ssX[3] = 0;
 }
 return sprite;
}
//PREPARAÇÃO DA TELA vv;
//Desenha os itens na tela;
void itens() {
  for (int y = 0; y < 15; y++) {
   for (int x = 0; x < 20; x++) {
    if (grid[y][x] ==  3) image(pinhao[0], x * 40, y * 40);
    else if (grid[y][x] == 4) image(buraco, x * 40, y * 40);
    else if (grid[y][x] == 5) image(pessego[0], x * 40, y * 40);
    else if (grid[y][x] == 6) image(penaAzul[0], x * 40, y * 40);
    else if (grid[y][x] == 7) image(penaPreta[0], x * 40, y * 40);
   }
  }
}
void prepLevel() {
  for (int i = 0; i < timer.length; i++) {
   timer[i] = 0; 
  }
  timerC[0] = 0;
  timerC[1] = 0;
  ativPessego = false;
  ativPenaAzul = false;
  ativPenaPreta = false;
  preso = false;
  atirar[0] = 0;
  atirar[1] = 0;
  rX[0] = cX[0] * 40;
  rY[0] = cY[0] * 40;
  rX[1] = cX[1] * 40;
  rY[1] = cY[1] * 40;
  d = 0;
  gD = "down";
  gV = 0.1;
  cV = 0.02;
  if (gameLevel == 0) {
    nBuraco[0] = 0;
    nPinhao[0] = 0;
    t[0] = 180;
    gX = 9;
    gY = 9;
    gvX = 9;
    gvY = 9;
    cX[0] = 2;
    cvX[0] = 2;
    cX[1] = 17;
    cvX[1] = 17;
    cY[0] = 13;
    cvY[0] = 13;
    cY[1] = 2;
    cvY[1] = 2;
    for (int y = 0; y < 15; y++) {
     for (int x = 0; x < 20; x++) grid[y][x] = level0[y][x]; 
    }
  } 
  if (gameLevel == 1) {
    nBuraco[1] = 0;
    nPinhao[1] = 0;
    t[1] = 180;
    gX = 1;
    gvX = 1;
    gY = 2;
    gvY = 2;
    cX[0] = 5;
    cvX[0] = 5;
    cY[0] = 10;
    cvY[0] = 10;
    cX[1] = 13;
    cvX[1] = 13;
    cY[1] = 6;
    cvY[1] = 6;
    for (int y = 0; y < 15; y++) {
     for (int x = 0; x < 20; x++) grid[y][x] = level1[y][x];
    } 
  }
  if (gameLevel == 2) {
    nBuraco[2] = 0;
    nPinhao[2] = 0;
    t[2] = 180;
    gX = 8;
    gvX = 8;
    gY = 11;
    gvY = 11;
    cX[0] = 1;
    cvX[0] = 1;
    cY[0] = 13;
    cvY[0] = 13;
    cX[1] = 18;
    cvX[1] = 18;
    cY[1] = 2;
    cvY[1] = 2;
    for (int y = 0; y < 15; y++) {
     for (int x = 0; x < 20; x++) grid[y][x] = level2[y][x];
    } 
  }
  if (gameLevel == 3) {
    nBuraco[3] = 0;
    nPinhao[3] = 0;
    t[3] = 180;
    gX = 1;
    gvX = 1;
    gY = 2;
    gvY = 2;
    cX[0] = 5;
    cvX[0] = 5;
    cY[0] = 6;
    cvY[0] = 6;
    cX[1] = 15;
    cvX[1] = 15;
    cY[1] = 12;
    cvY[1] = 12;
    for (int y = 0; y < 15; y++) {
     for (int x = 0; x < 20; x++) grid[y][x] = level3[y][x];
    } 
  }  
}
void nPinhaoLevel() {
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < 20; x++) {
      if (level0[y][x] == 3) nPinhaoLevel[0]++;
      if (level1[y][x] == 3) nPinhaoLevel[1]++;
      if (level2[y][x] == 3) nPinhaoLevel[2]++;
      if (level3[y][x] == 3) nPinhaoLevel[3]++;
    }
  } 
}

//POWER-UP'S AQUI vv;
void powerUps() {
 if (ativPessego) {
  timer[4]++;
  if (timer[4] >= 240) {
   timer[4] = 0;
   timer[2] = 0;
   timer[10] = 120;
   ativPessego = false;
  } 
 } else timer[4] = 0;
 if (ativPenaAzul) {
  timer[5]++;
  gV = 0.2;
  if (timer[5] >= 180 && timer[1] == 0) {
   timer[5] = 0;
   ativPenaAzul = false;
   gV = 0.1;
  }
 } else timer[5] = 0;
}

//VITÓRIA,  DERROTA E PAUSE AQUI vv;
void gameWin(int i) {
  if (nBuraco[i] == nPinhaoLevel[i]) {
    venceu = true;
    
  }
  if (venceu) {
   image(venceuMenu, 0, 0);
   if (enter) {
     if (gameLevel == 3) {
       nWin++;
       venceu = false;
       gameScreen = 10;
       timer[18] = 0;
     } else {
       venceu = false;
       gameScreen = 7;
       timer[18] = 0;
     }
   }
  }
}
void gameLose(int n) {
  for (int i = 0; i < 2; i++) {
   if (colisao((gvX * 40) + 10, (gvY * 40) + 10, TILEWIDTH, TILEHEIGHT, (cvX[i] * 40) + 10, (cvY[i] * 40) + 10, TILEWIDTH, TILEHEIGHT) && ativPessego != true) {
     gritoSom.pause();
     perdeu = true;
     image(perdeuMenu[0], 0, 0);
     if (enter) {
       perdeu = false;
       gameScreen = 8;
      }
    }
  }
  if (t[n] == 0) {
   perdeu = true;
   image(perdeuMenu[1], 0, 0);
   if (enter) {
   perdeu = false;
   gameScreen = 8;
  }
 } 
}
void gamePause() {
 timer[18]++;
 if (timer[18] > 30 && enter && (venceu != true && perdeu != true)) {
   pause = true;
 }
   timer[17]++;
   image(pauseMenu, 0, 0);
   if ((mouseX > 290 && mouseX < 505) && (mouseY > 240 && mouseY < 275)) {
   image(voltarMenu[1], 290, 240);                 //Botão Voltar Menu;
  } else image(voltarMenu[0], 290, 240);
   if ((mouseX > 278 && mouseX < 522) && (mouseY > 336 && mouseY < 372)) {
   image(continuar[1], 278, 336);                 //Botão Continuar;
  } else image(continuar[0], 278, 336);
   if (timer[17] >= 30 && enter) {
    timer[18] = 0;
    timer[17] = 0;
    pause = false;
   }
}

//HUD AQUI vv;
void hud(int i) {
  textAlign(LEFT, CENTER);
  textSize(18);
  fill(255,255,255);
  text("Pinhão: " + nPinhao[i], 550, 18);
  image(pinhao[1], 630, 0, 40, 40);
  text("Score: " + score[i], 680, 18);
  countDown(gameLevel);
  if (ativPessego) image(pessego[2], 390, 0, 40, 40);
  else image(pessego[1], 390, 0, 40, 40);
  if (ativPenaAzul) image(penaAzul[2], 440, 0, 40, 40);
  else image(penaAzul[1], 440, 0, 40, 40);
  if (nPenaPreta > 0) ativPenaPreta = true;
  else ativPenaPreta = false;
  if (ativPenaPreta) image(penaPreta[2], 490, 0, 40, 40);
  else image(penaPreta[1], 490, 0, 40, 40);
}
//Função cálculo do tempo
void clock(int t) {
  int h = t / 60;
  int m = t % 60;
  String hora = nf(h, 2);
  String minuto = nf(m, 2);
  textSize (24);
  fill(255,255,255);
  if (t <= 20) fill(255,100,100);
  if (t == 20) tempoSom.play();
  text(hora + ":" + minuto, 20, 18);
}
//Função do timer do tempo;
void timer(int i) {
  timer[13]++;
  if (timer[13] >= 60) {
   timer[13] = 0;
   t[i]--;
  }
}
//Função do tempo;
void countDown(int i) {
 clock(t[i]);
 timer(i);
}

//Função de pontuação;
void score() {
  score[0] = (nBuraco[0] * 100) + scorePU[0] + (nPinhao[0] * 50);
  for (int i = 0; i < 4; i++) {
  scoreTempo[i] = t[i] * 40;
  scoreFinal[i] = score[i] + scoreTempo[i];
  }
  for (int n = 0; n < 3; n++) {
   score[n + 1] = scoreFinal[n] + (nBuraco[n + 1] * 100) + scorePU[n + 1] + (nPinhao[n + 1] * 50); 
  }
}
void ordenar() {
  for (int i = 0; i < highScore.length; i++) {
 for (int n = i + 1; n < highScore.length; n++) {
   if (highScore[n] > highScore[i]) {
    highScoreAtual = highScore[i];
    highScore[i] = highScore[n];
    highScore[n] = highScoreAtual;
   }
 }
}
}

//VERSÃO DO JOGO vv;
void versao() {
    fill(255,255,255);
 textSize(11);
 textAlign(LEFT);
 text(versao, 18, 580);
}