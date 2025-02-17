#define SENSOR_A_PIN A1
#define SENSOR_B_PIN A2

int sensor_a_value = 0;
int sensor_b_value = 0;

bool sensor_a_state = false;
bool sensor_b_state = false;

int threshold = 900;

bool is_active = true;

bool activate = false;

void setup() {
  Serial.begin(115200);
  pinMode(SENSOR_A_PIN, INPUT);  
  pinMode(SENSOR_B_PIN, INPUT); 
}

void loop() {
  if(Serial.available() > 0) is_active = Serial.read();

  if(is_active){
    sensor_a_value = analogRead(SENSOR_A_PIN);
    sensor_b_value = analogRead(SENSOR_B_PIN);

    sensor_a_state = sensor_a_value < threshold;
    sensor_b_state = sensor_b_value < threshold;

    if(sensor_a_state) activate = true;
    else if(sensor_b_state) activate = false;
  }else activate = false;

  Serial.write(activate);
}




