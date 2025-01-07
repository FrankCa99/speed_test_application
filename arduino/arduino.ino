#include <BluetoothSerial.h>

#define SENSOR_A_PIN 12
#define SENSOR_B_PIN 14

BluetoothSerial SerialBt;

bool activated = false;
bool isRunning = false;

void setup() {
  // put your setup code here, to run once:
  SerialBt.begin("Speed Monitor");

  pinMode(SENSOR_A_PIN, INPUT_PULLUP);
  pinMode(SENSOR_B_PIN, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(SerialBt.available() > 0) isRunning = SerialBt.read();;
  if(isRunning){
    if(!digitalRead(SENSOR_A_PIN)) activated = true;
    else if(!digitalRead(SENSOR_B_PIN)) activated = false;
  }else activated = false;
  SerialBt.write(activated);
  delay(1);
}