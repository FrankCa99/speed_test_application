#define SENSOR_A_PIN 2
#define SENSOR_B_PIN 4

boolean activated = false;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  pinMode(SENSOR_A_PIN, INPUT_PULLUP);
  pinMode(SENSOR_B_PIN, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(!digitalRead(SENSOR_A_PIN)) activated = true;
  else if(!digitalRead(SENSOR_B_PIN)) activated = false;
  
  Serial.write(activated);
}
