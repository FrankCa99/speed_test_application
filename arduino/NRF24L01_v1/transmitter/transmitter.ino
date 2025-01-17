#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

#define CE_PIN 7
#define CSN_PIN 8

#define SENSOR_A_PIN 2
#define SENSOR_B_PIN 3

RF24 radio(CE_PIN, CSN_PIN);
const byte addrs[6] = "00001";

void setup() {
  Serial.begin(115200);

  pinMode(SENSOR_A_PIN, INPUT_PULLUP);
  pinMode(SENSOR_B_PIN, INPUT_PULLUP);
    
    //start the radio 
  radio.begin();
  radio.openWritingPipe(addrs);
  radio.setPALevel(RF24_PA_LOW);
  radio.setDataRate(RF24_2MBPS); // Increase data rate
  radio.setChannel(100);         // Avoid interference
  radio.stopListening();
}

void loop() {
    // prepare data
  int data[2] = {!digitalRead(SENSOR_A_PIN), !digitalRead(SENSOR_B_PIN)};
    // send data
  radio.write(&data, sizeof(data));
    //breath my child
  delay(1);
}
