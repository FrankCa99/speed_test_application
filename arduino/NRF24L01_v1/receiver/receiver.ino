#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

#define CE_PIN 7
#define CSN_PIN 8

RF24 radio(CE_PIN, CSN_PIN);
const byte addrs[6] = "00001";

bool activated = false;
bool isRunning = false;

int data[2];

void setup() {
  Serial.begin(115200); // start comm on the port 
  radio.begin(); // start comm with the other module
  radio.openReadingPipe(0, addrs);
  radio.setPALevel(RF24_PA_LOW);
  radio.setDataRate(RF24_2MBPS); // Match transmitter data rate
  radio.setChannel(100);         // Match transmitter channel
  radio.startListening();
}

void loop() {
  if(Serial.available() > 0) isRunning = Serial.read(); // read from port
  
  if(isRunning){
    if(radio.available() > 0) radio.read(&data, sizeof(data)); // read from other module
    if(boolean(data[0])) activated = true;
    else if(boolean(data[1])) activated = false;
  }else activated = false;

  Serial.write(activated);
}
