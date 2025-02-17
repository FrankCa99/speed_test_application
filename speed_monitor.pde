import processing.serial.*;

float counter = 0;

float time = 0;
float distance = 1; // in meters
float speed = 0;

Button run_button;
Button reset_button;
Button edit_button;

Gauge mph_speed_gauge;
Gauge kph_speed_gauge;

LabelDisplay current_time;

State inRange;

Serial port;
boolean sensor_state = false;

void setup(){
            //default code, DO NOT EDIT!\\
  windowTitle(APPLICATION_NAME);
  textFont(createFont("fonts/Baloo2-Medium.ttf", DEFAULT_FONT_SIZE)); //NOTE: copy and past the "font" folder in the final application
  size(450, 580); // if this changing, make sure to also change it in the "Constants" tab

  // creates the buttons
  run_button = new Button(new PVector(CENTER_X - BUTTON_SIZE/2, 10), new PVector(BUTTON_SIZE, BUTTON_SIZE/2), "RUN", green_theme);
  reset_button = new Button(new PVector(CENTER_X - (BUTTON_SIZE + (BUTTON_SIZE*0.5)) - 10, 10), new PVector(BUTTON_SIZE, BUTTON_SIZE/2), "RESET", red_theme);
  edit_button = new Button(new PVector(CENTER_X + (BUTTON_SIZE - (BUTTON_SIZE*0.5)) + 10, 10), new PVector(BUTTON_SIZE, BUTTON_SIZE/2), "EDIT", orange_theme);
  
  // creates the gauges
  mph_speed_gauge = new Gauge("MPH", new PVector(CENTER_X - 110, height/8), 220, 50, red_theme);
  kph_speed_gauge = new Gauge("KPH", new PVector(CENTER_X - 80, height/2), 160, 50, green_theme);
  
  // creates a text display with the current time in millis
  current_time = new LabelDisplay("CURRENT TIME", new PVector(CENTER_X - 50, 500), orange_theme);
  
  // creates a simple on and of display
  inRange = new State("IN RANGE", new PVector(CENTER_X - 34, 450), new PVector(75, 50),  green_theme);
  
  // creates a port to read from the arduino
  port = new Serial(this, Serial.list()[0], 115200);
  //port = new Serial(this, "COM3", 115200);
}
void draw(){
  cursor(ARROW); // can be improve to prevent the pointer twitching
  background(background_color);
  
   // displays all the elemets on the canvas
  run_button.display();
  reset_button.display();
  edit_button.display();
  
  mph_speed_gauge.display();
  kph_speed_gauge.display();
  
  current_time.display();
  
  inRange.display();
    // done displaying everything
  
          //// handling events(can improve)\\\\
  if(edit_button.is_toggle() && !run_button.is_active){
    // whenever edit button is active, gauges can be moved 
    mph_speed_gauge.area.drag_and_drop();
    kph_speed_gauge.area.drag_and_drop();
    current_time.area.drag_and_drop();
    inRange.area.drag_and_drop();
    
    //enable edit button and disable others
    edit_button.is_disabled = false;
    run_button.is_disabled = true;
    reset_button.is_disabled = true;
    
  }else if(run_button.is_toggle() && !edit_button.is_active){ // whenever run button is active, disable edit button
    run_button.is_disabled = false;
    edit_button.is_disabled = true;
    
    port.write(byte(true)); // tell the MCU to start recording the time
    while(port.available() > 0){
      boolean incoming_data = boolean(port.read());
      sensor_state = incoming_data;
      inRange.update_state(sensor_state);
    }
    if(inRange.state_b){
      //calculates the speed in meters per second
      counter ++;
      time = (counter / frameRate);
      speed = (distance / time);
      current_time.update_value(time);
      
      //update the values of the gauges to respective speed format
      mph_speed_gauge.update_value(speed * 2.23694);
      kph_speed_gauge.update_value(speed * 3.6);
      
    }else counter = 0;
    
  }else{
    // if none are active, set everything to normal
    run_button.is_disabled = false;
    edit_button.is_disabled = false;
    reset_button.is_disabled = false;
    reset_button.is_active = false;
    // tells the MCU to stop recording the time
    port.write(byte(false));
    
    // when reset is pressed
    if(!(run_button.is_active || edit_button.is_active)){
      if(reset_button.is_clicked()){
        // reset everything
        mph_speed_gauge.update_value(0);
        kph_speed_gauge.update_value(0);      
        current_time.update_value(0);
        inRange.update_state(false);    
      }else reset_button.is_active = reset_button.is_mouse_over();
    }
  }
}
