//Speed Testing Apparatus Version 2 Updated 11.22.24

//Setup
const int Sensor1 = 2;                                                      // Sensor1 is assigned to pin 2 
const int Sensor2 = 4;                                                      // Sensor2 is assigned to pin 3 
const float distance = 4;                                                 // distance between Sensor1 and Sensor2 in meters

unsigned long startTime = 0;                                                // Variable to store the start time
unsigned long stopTime = 0;                                                 // Variable to store the stop time
bool timerRunning = false;                                                  // Flag to track if the timer is running
bool sensor1Enabled = true;                                                 // Flag to track if enable/disable Sensor1 logic
bool sensor2Enabled = true;                                                 // Flag to track if enable/disable Sensor2 logic
byte data[2];


// put your setup code here, to run once:
void setup() 
{
  pinMode (Sensor1, INPUT);                                                 // Defines Sensor1 as an input pin
  pinMode (Sensor2, INPUT);                                                 // Defines Sensor2 as an input pin
  sensor2Enabled = false;                                                   // Turns Sensor 2 off 
  Serial.begin(115200); 
  // Serial.println(" ");
  // Serial.println ("Speed Testing Apparatus Starting");
  // Serial.println("Sensor 1 enabled.");
  // Serial.println("Sensor 2 disabled.");
  // Serial.println ("3, 2, 1 Go!");
  // Serial.println(" ");
}

// put your main code here, to run repeatedly:

void loop() 
{
 
  if(sensor1Enabled && digitalRead (Sensor1) == LOW && !timerRunning)       // Low = that the beam of light/laser has been disturbed
    {
      startTime = millis();                                                 // Record the start time in ms
      timerRunning = true;                                                  // Set the timer running flag
      // Serial.println("Timer started.");
      // Serial.print("Starting time value is ");                              // Prints time value
      // Serial.print(startTime);                                                
      // Serial.println(" miliseconds."); 
      
      sensor1Enabled = false;                                               // Turns off Sensor1
      // Serial.println("Sensor 1 disabled.");
      sensor2Enabled = true;                                                // Turns on Sensor2
      // Serial.println("Sensor 2 is enabled.");
    }

  if(sensor2Enabled && digitalRead (Sensor2) == LOW)                       // Low = that the leam of light/laser has been distrubed
    {
      stopTime = millis();                                                 // Record the stop time
      timerRunning = false;                                                // Stop the timer
      // Serial.println("Timer stopped.");
      // Serial.print("Ending time value is ");
      // Serial.print(stopTime); 
      // Serial.println(" milliseconds.");
      sensor2Enabled = false;                                              // Prints time values

      float elapsedTime = (stopTime - startTime) / 1000.0;                 // Calculate elapsed time in seconds
      float speed = distance / elapsedTime;                                // Calculate speed (distance/time)

      // Serial.print("Elapsed time: ");                                      // Displays the Results 
      // Serial.print(elapsedTime);
      // Serial.println(" seconds");
      // Serial.println(" ");

      // Serial.print("Calculated speed: ");
      // Serial.print(speed);
      // Serial.println(" m/s");
      //Serial.println(" ");

      float speedkm = speed / 1000;                                      // Converts "speed" (m/s) to km/s denoted as "speedkm"
      // Serial.print("Calculated speed: ");
      // Serial.print(speedkm);
      // Serial.println(" km/s");
      //Serial.println(" ");

      float speedUSA = speed * 2.23694;                                   // Converts "speed" (m/s) to mph denoted as "speedUSA"
      // Serial.print("Calculated speed for the USA: ");
      // Serial.print(speedUSA);
      // Serial.println(" mph");
      // Serial.println(" ");

      sensor2Enabled = false;                                             // Resets the sensors (for code to loop again)
      sensor1Enabled = true; 

      // Serial.println("Test Restarted!");
      // Serial.println("Sensor 1 enabled.");
      // Serial.println("Sensor 2 disabled.");
      // Serial.println ("3, 2, 1 Go!");
    }
  data[0] = sensor1Enabled;
  data[1] = sensor2Enabled;
  Serial.write(data, 2);
}
