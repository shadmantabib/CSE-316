#include<SoftwareSerial.h>

SoftwareSerial mySerial(10, 11);    //Rx, Tx   ,  Bluetoot Tx - 10, Bluetooth Rx - 11

int in1 = 2; 
int in2 = 3;
int in3 = 4;
int in4 = 5;

int car=0;

void setup()
{
  mySerial.begin(9600);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
}

void loop()
{
  char data;
  if(mySerial.available())
    {
      data = mySerial.read();
      if(data == '1')   //Forward
        {
          if(car == 1)
            {
              digitalWrite(in1, LOW);
              digitalWrite(in2, LOW);
              digitalWrite(in3, LOW);
              digitalWrite(in4, LOW);
              car = 0;
              Serial.println("Stop");
            }
          else
            {
              digitalWrite(in1, HIGH);
              digitalWrite(in2, LOW);
              digitalWrite(in3, HIGH);
              digitalWrite(in4, LOW);
              car = 1;
              Serial.println("Forward");
            }
        }

  if(data == '2')   //Reverse
          {
            if(car == 2)
              {
                digitalWrite(in1, LOW);
                digitalWrite(in2, LOW);
                digitalWrite(in3, LOW);
                digitalWrite(in4, LOW);
                car = 0;
                Serial.println("Stop");
              }
            else
              {
                digitalWrite(in1, LOW);
                digitalWrite(in2, HIGH);
                digitalWrite(in3, LOW);
                digitalWrite(in4, HIGH);
                car = 2;
                Serial.println("Reverse");
              }
          }

  if(data == '3')   //Right
            {
              if(car == 3)
                {
                  digitalWrite(in1, LOW);
                  digitalWrite(in2, LOW);
                  digitalWrite(in3, LOW);
                  digitalWrite(in4, LOW);
                  car = 0;
                  Serial.println("Stop");
                }
              else
                {
                  digitalWrite(in1, HIGH);
                  digitalWrite(in2, LOW);
                  digitalWrite(in3, LOW);
                  digitalWrite(in4, HIGH);
                  car = 3;
                  Serial.println("Right");
                }
            }
            
  if(data == '4')   //Left
          {
            if(car == 4)
              {
                digitalWrite(in1, LOW);
                digitalWrite(in2, LOW);
                digitalWrite(in3, LOW);
                digitalWrite(in4, LOW);
                car = 0;
                Serial.println("Stop");
              }
            else
              {
                digitalWrite(in1, LOW);
                digitalWrite(in2, HIGH);
                digitalWrite(in3, HIGH);
                digitalWrite(in4, LOW);
                car = 4;
                Serial.println("Forward");
              }
          }
    }
}
