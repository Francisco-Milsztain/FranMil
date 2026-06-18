//PARA CAMBIBAR DESPUES:
//1500ms = 90° (MAL)(aporx 0.65 segs)
//2500ms = 360(Suposicion)
//1500ms = DE ABAJO AL MEDIO (NO CREO NI CONFIO)

#define STRAT1 1
#define STRAT2 2
#define STRAT3 3
int swiestrat = STRAT1;

//Variables aparte
int giro = 0;
int borde = 0;
int detectarop = 0;
int SecuInEnd = 0;

//Timers
unsigned long segundos; // = millis()
unsigned long tiempo1;  //tiempo para el borde
int trabatiempo1 = 0;
                        //de acá para abajo son tiempos para timings adentro de las estrategias
unsigned long tiempo2a; 
int trabatiempo2a = 0;
unsigned long tiempo2b;
int trabatiempo2b = 0;
unsigned long tiempo2c;
int trabatiempo2c = 0;
unsigned long tiempo2d;
int trabatiempo2d = 0;

//Inicio (5 segundos)
const int bot5segs = A7; //pin del pulsador incio
int lecturafive;         //lectura del pin bot5segs
int botfive = 0;         //variable que se modifica al presionar el pulsador
int trabafive = 0;       //bloqueo del pulsador, para que este deba ser soltado antes de presionarse nuevamente
unsigned long timerfive; //contador de 5 segundos
int trabatimerfive = 0;  //traba del contador de 5 segundos
int comienzorobot = 0;   //variable que se modifica al haber pasado 5 segundos

//Estrategias
const int botestrategia = A6; //pin del pulsador de estrategia
int lecturaBotStrat;          //lectura del pin botestrategia
int trabastrat = 0;           //bloqueo del pulsador, para que este deba ser soltado antes de presionarse nuevamente
int estrategia = 0;           //variable que se modifica cada vez que se oprime el pulsador

//Led
const int led = A5;

//Ultrasonidos
const int trig1 = A3;
const int echo1 = A4;
const int trig2 = 9;
const int echo2 = 10;
const int trig3 = 11;
const int echo3 = 12;

long temp1;
long dist1;
long temp2;
long dist2;
long temp3;
long dist3;

//Piso
const int piso1 = A2;
const int piso2 = A1;
int valorpiso1;
int valorpiso2;

//Motores
int pwm1 = 7;
int pwm2 = 6;
int motor1A = 5; //high = adelante
int motor1B = 4; //high = atras
int motor2A = 8; //high = adelante
int motor2B = 3; //high = atras


//FUNCIONES MOTORES
void adelante()
{
  digitalWrite(motor1A, HIGH);
  digitalWrite(motor1B, LOW);

  digitalWrite(motor2A, HIGH);
  digitalWrite(motor2B, LOW);
}

void atras()
{
  digitalWrite(motor1A, LOW);
  digitalWrite(motor1B, HIGH);

  digitalWrite(motor2A, LOW);
  digitalWrite(motor2B, HIGH);
}

void izquierda()
{
  digitalWrite(motor1A, LOW);
  digitalWrite(motor1B, HIGH);

  digitalWrite(motor2A, HIGH);
  digitalWrite(motor2B, LOW);
}

void derecha()
{
  digitalWrite(motor1A, HIGH);
  digitalWrite(motor1B, LOW);

  digitalWrite(motor2A, LOW);
  digitalWrite(motor2B, HIGH);
}

void parar()
{
  digitalWrite(motor1A, LOW);
  digitalWrite(motor1B, LOW);

  digitalWrite(motor2A, LOW);
  digitalWrite(motor2B, LOW);
}

void setup ()
{
  Serial.begin(9600);
  
  //boton estrategia
  pinMode(botestrategia, INPUT);
  estrategia = 1;
  
  //boton inicio (inicio = 5 segs)
  pinMode(bot5segs, INPUT);
  botfive = 0;
  timerfive = 0;
  comienzorobot = 0;

  //led
  analogWrite(led, 0);
  
  //3 sensores ultrasonido
  pinMode(trig1, OUTPUT);
  pinMode(echo1, INPUT);
  digitalWrite(trig1, LOW);

  pinMode(trig2, OUTPUT);
  pinMode(echo2, INPUT);
  digitalWrite(trig2, LOW);

  pinMode(trig3, OUTPUT);
  pinMode(echo3, INPUT);
  digitalWrite(trig3, LOW);

  //2 sensores piso
  pinMode(piso1, INPUT);
  pinMode(piso2, INPUT);

  //motores
  digitalWrite(pwm1, 255);
  digitalWrite(pwm2, 255);
  pinMode(motor1A, OUTPUT);
  pinMode(motor1B, OUTPUT);
  pinMode(motor2A, OUTPUT);
  pinMode(motor2B, OUTPUT);
}

void loop ()
{
  segundos = millis();  
  
  //Ultrasonidos:
  //ultra1
  digitalWrite(trig1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig1, LOW);
  temp1 = pulseIn(echo1, HIGH);
  dist1 = temp1 / 59;

  //ultra2
  digitalWrite(trig2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig2, LOW);
  temp2 = pulseIn(echo2, HIGH);
  dist2 = temp2 / 59;

  //ultra3
  digitalWrite(trig3, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig3, LOW);
  temp3 = pulseIn(echo3, HIGH);
  dist3 = temp3 / 59;

  //Sensores de Piso
  valorpiso1 = analogRead(piso1);
  valorpiso2 = analogRead(piso2);
  
  //Boton de Inicio
  lecturafive = digitalRead(bot5segs);

    if (lecturafive == 1 && trabafive == 0) 
    {
      botfive = 1;
      trabafive = 1;
    }

    if (lecturafive == 0)
    {
      trabafive = 0;
    }  
  
  //BOTON DE ESTRATEGIAS
  lecturaBotStrat = digitalRead(botestrategia);

  if (lecturaBotStrat == 1 && trabastrat == 0)
  {
    estrategia = estrategia + 1;
    trabastrat = 1;
  }

  if (lecturaBotStrat == 0)
  {
    trabastrat = 0;
  }

  if (estrategia == 1)
  {
    swiestrat = STRAT1;
  }
    
  if (estrategia == 2)
  {
    swiestrat = STRAT2;
  }
    
  if (estrategia == 3)
  {
    swiestrat = STRAT3;
  }
    
  if (estrategia == 4 || estrategia == 0)
  {
    estrategia = 1;
  }

  //Contador de 5 Segundos
  if (botfive == 1) 
  {
    if (trabatimerfive = 0)
    {
      timerfive = segundos + 5000;
      trabatimerfive = 1;
    }
    
    if (segundos > timerfive)
    {
      comienzorobot = 1;
      trabatimerfive = 0;
    }
  }

  //ESTRATEGIAS
  if (comienzorobot == 1)
  {
    switch (swiestrat)
    {
      //Tiempo1 para borde
      //Tiempos 2a y 2b, 2c, y 2d para secuencia inicio

    case STRAT1: //ESTRATEGIA 1
      analogWrite(led, 0); 
      
      //detectar piso
      if (valorpiso1 >= 100 || valorpiso2 >= 100)
      {
        borde = 1;
      }

      if (borde == 1)
      {
        if (trabatiempo1 = 0)
        {
          tiempo1 = segundos + 1500;
          atras();
          trabatiempo1 = 1;
        }

        if (segundos > tiempo1)
        {
          trabatiempo1 = 0;
          borde = 0;
        }
      }
      
      //todo lo de abajo pasa si el piso es negro
      if (borde == 0)
      {
      if (dist1 < 110 || dist2 < 110 || dist3 < 110)	
        {
          detectarop = 1;
          giro = 1; //luego de ver al oponente giro = 1 para siempre
        }

        if (dist1 > 110 || dist2 > 110 || dist3 > 110)
        {
          detectarop = 0;
        }

        //Seguir al oponente
        if (detectarop == 1)
        {
          if (dist1 <= 110 && dist2 >= 110 && dist3 >= 110)
          {
            izquierda();
          }

          if (dist3 <= 110 && dist2 >= 110 && dist1 >= 110)
          {
            derecha();
          }

          if (dist2 <= 110)
          {
            adelante();
          }
        }
        
        //Secuencia inicio
        if (detectarop == 0 && giro == 0) 
        {
          if (trabatiempo2a == 0 && trabatiempo2b == 0)
          {
            tiempo2a = segundos + 2000;
            tiempo2b = tiempo2a + 2000;

            trabatiempo2a = 1;
            trabatiempo2b = 1;
          }
          
          if (tiempo2a > segundos)
          {
            derecha();
          }
          if (segundos > tiempo2a)
          {
            trabatiempo2a = 0;
          }

          if (tiempo2b > segundos && trabatiempo2a == 0)
          {
            izquierda();
          }
          if (segundos > tiempo2b)
          {
            trabatiempo2b = 0;
          }
        }

        //Lo que pasa si no vemos actualmente al opoente, pero previamente lo vimos
        if (detectarop == 0 && giro == 1)
        {
          derecha();
        }
      }
    break;


    case STRAT2: //ESTRATEGIA 2
      analogWrite(led, 90);
      
      //detectar piso
        if (valorpiso1 >= 100 || valorpiso2 >= 100)
      {
        borde = 1;
      }

      if (borde == 1)
      {
        if (trabatiempo1 = 0)
        {
          tiempo1 = segundos + 1500;
          atras();
          trabatiempo1 = 1;
        }

        if (segundos > tiempo1)
        {
          trabatiempo1 = 0;
          borde = 0;
        }
      }

      //todo lo de abajo pasa si el piso es negro
      if (borde == 0)
      {
        if (dist1 < 110 || dist2 < 110 || dist3 < 110)	
        {
          detectarop = 1;
          giro = 1;
        }
        
        if (dist1 > 110 || dist2 > 110 || dist3 > 110)
        {
          detectarop = 0;
        }
        
        if (detectarop == 1)
        {
          if (dist1 <= 110 && dist2 >= 110 && dist3 >= 110)
          {
            izquierda();
          }

          if (dist3 <= 110 && dist2 >= 110 && dist1 >= 110)
          {
            derecha();
          }

          if (dist2 <= 110)
          {
            adelante();
          }
        }
        
        //Secuencia inicio
        if (detectarop == 0 && giro == 0)
        {
          if (trabatiempo2a == 0)
          {
            tiempo2a = segundos + 1500;
            trabatiempo2a = 1;
          }

          if (segundos <= tiempo2a) //se avanza por 1,5 segs
          {
            adelante();
          }
          
          if (segundos >= tiempo2a) //luego de que pasan 1,5 segs
          {
            if (trabatiempo2b == 0)
            {
              tiempo2b = segundos + 1500;
              trabatiempo2b = 1;
            }
          
            if (segundos <= tiempo2b) //se gira a la derecha por 1,5 segs
            {
              derecha();
            }
            
            if (segundos >= tiempo2b) //cuando pasan 1,5 segs se avanza (hasta el borde)
            {
              adelante();
            }
          }
          
          //Lo que pasa si no vemos actualmente al opoente, pero previamente lo vimos
          if (detectarop == 0 && giro == 1)
          {
            derecha();
          }
        }
      }
    break;


    case STRAT3: //ESTRATEGIA 3
      analogWrite(led, 255);
      
      //detectar piso
      if (valorpiso1 >= 100 || valorpiso2 >= 100)
      {
        borde = 1;
      }

      if (borde == 1)
      {
        if (trabatiempo1 = 0)
        {
          tiempo1 = segundos + 1500;
          atras();
          trabatiempo1 = 1;
        }

        if (segundos > tiempo1)
        {
          trabatiempo1 = 0;
          borde = 0;
        }
      }
      
      //todo lo de abajo pasa si el piso es negro
      if (borde == 0)
      {
        if (dist1 < 110 || dist2 < 110 || dist3 < 110)	
        {
          detectarop = 1;
          giro = 1;
        }
        
        if (dist1 > 110 || dist2 > 110 || dist3 > 110)
        {
          detectarop = 0;
        }
        
        if (detectarop == 1)
        {
          if (dist1 <= 110 && dist2 >= 110 && dist3 >= 110)
          {
            izquierda();
          }

          if (dist3 <= 110 && dist2 >= 110 && dist1 >= 110)
          {
            derecha();
          }

          if (dist2 <= 110)
          {
            adelante();
          }
        }
        
        //Secuencia inicio
        if (detectarop == 0 && giro == 0)
        {
          if (trabatiempo2a = 0)
          {
            tiempo2a = segundos + 1500;
            trabatiempo2a = 1;
          }
          
          if (segundos <= tiempo2a) //se avanza por 1,5 segs
          {
            adelante();
          }
          
          if (segundos >= tiempo2a) //luego de que pasan 1,5 segs
          {
            if (trabatiempo2b = 0)
            {
              tiempo2b = segundos + 1500;
              trabatiempo2b = 1;
            }
          
            if (segundos <= tiempo2b) //se gira a la derecha por 1,5 segs
            {
              derecha();
            }
            
            if (segundos >= tiempo2b) //cuando pasan 1,5 segs se avanza (hasta el borde)
            {
              SecuInEnd = 1;
            }
          }
          
          if (detectarop == 0 && giro == 0 && SecuInEnd == 1)
          {
            if (trabatiempo2c = 0)
            {
              tiempo2c = segundos + 2000;
              trabatiempo2c = 1;
            }
            
            if (segundos < tiempo2c)
            {
              adelante();
            }
            
            if (segundos > tiempo2c)
            {
              if (trabatiempo2d = 0)
              {
                tiempo2d = segundos + 2500;
                trabatiempo2d = 1;
              }
              
              if (segundos < tiempo2d)
              {
                derecha();
              }
            }
          }

          //Lo que pasa si no vemos actualmente al opoente, pero previamente lo vimos
          if (detectarop == 0 && giro == 1)
          {
            if (trabatiempo2c == 0 && trabatiempo2d == 0)
            {
              tiempo2c = segundos + 1500;
              trabatiempo2c = 1;
            }
            
            if (segundos < tiempo2c)
            {
              derecha();
            }
            
            if (segundos > tiempo2c)
            {
              if (trabatiempo2d = 0)
              {
                tiempo2d = segundos + 2000;
                trabatiempo2c = 0;
                trabatiempo2d = 1;
              }
              
              if (segundos < tiempo2d)
              {
                adelante();
              }

              if (segundos > tiempo2d)
              {
                trabatiempo2d = 0;
              }
            }
          }
        }
      }
    break;

    }
  }
}