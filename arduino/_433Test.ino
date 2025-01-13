#define sensor_a_target_freq 104.0
#define sensor_b_target_freq 88.0
#define signal_pin 4

float tolerance = 10;

bool sensor_a = false;
bool sensor_b = false;

const int error_size = 2;
bool error_a[error_size];
bool error_b[error_size];

bool is_running = true;
bool is_activated = false;

void setup() {
  Serial.begin(115200); // Initialize Serial Monitor
  pinMode(4, INPUT_PULLUP);  // Set pin 7 as input
}

void loop() {

  if(Serial.available() > 0) is_running = Serial.read();
  //latch logic
  if(is_running){
  //checks for frequencies 
  for(int i = 0; i < error_size; i++){
    error_a[i] = detect_frequency(signal_pin, sensor_a_target_freq, tolerance);
    error_b[i] = detect_frequency(signal_pin, sensor_b_target_freq, tolerance);
  }
    sensor_a = valueRepeats(error_a, error_size, true);
    sensor_b = valueRepeats(error_b, error_size, true);
    
    if(sensor_a) is_activated = true;
    else if(sensor_b) is_activated = false;
  }else is_activated = false;

  Serial.write(is_activated);

  delay(1); // delay 1 ms
}
bool valueRepeats(bool arr[], int size, bool value) {
  for (int i = 0; i < size; i++) {
    if (arr[i] == value) {
      // If we find the value again, return true
      for (int j = i + 1; j < size; j++) {
        if (arr[j] == value) {
          return true; // The value repeats
        }
      }
    }
  }
  return false; // The value doesn't repeat
}

// Function to detect a specific frequency
bool detect_frequency(int pin, float targetFrequency, float tolerance) {
  // Read high and low pulse durations
  unsigned long highDuration = pulseIn(pin, HIGH);
  unsigned long lowDuration = pulseIn(pin, LOW);

  // If pulse durations are zero, no signal is detected
  if (highDuration == 0 || lowDuration == 0) return false;

  // Calculate the period and frequency
  float period = highDuration + lowDuration; // Total time for one cycle
  float frequency = 1000000.0 / period;     // Convert period (microseconds) to frequency (Hz)

  // Check if the measured frequency is within the tolerance range
  return abs(frequency - targetFrequency) <= tolerance;
}