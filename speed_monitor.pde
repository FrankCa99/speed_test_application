import processing.serial.*;

int size_ratio = 75;
float counter = 0;

float time = 0;
float distance = 3; // in meters
float speed = 0;

Button run_button;
Button reset_button;
Button edit_button;

Gauge current_speed_gauge;
Gauge max_speed_gauge;

Timer current_time;

State inRange;

boolean sensor_state = false;

Serial port;
byte[] data = new byte[2];

void setup(){
            //default code, DO NOT EDIT!\\ 
  windowTitle(APPLICATION_NAME);
  textFont(createFont("fonts/Baloo2-Medium.ttf", DEFAULT_FONT_SIZE)); //NOTE: copy and past the "font" folder in the final application
  size(450, 580); // if this changing, make sure to also change it in the "Constants" tab

  run_button = new Button(new PVector(CENTER_X - size_ratio/2, 10), new PVector(size_ratio, size_ratio/2), "RUN", green_theme);
  reset_button = new Button(new PVector(CENTER_X - (size_ratio + (size_ratio*0.5)) - 10, 10), new PVector(size_ratio, size_ratio/2), "RESET", red_theme);
  edit_button = new Button(new PVector(CENTER_X + (size_ratio - (size_ratio*0.5)) + 10, 10), new PVector(size_ratio, size_ratio/2), "EDIT", orange_theme);
  
  current_speed_gauge = new Gauge("CURRENT SPEED", new PVector(CENTER_X - 110, height/8), 220, 50, red_theme);
  max_speed_gauge = new Gauge("PREVIOUS SPEED", new PVector(CENTER_X - 80, height/2), 160, 50, green_theme);
  
  current_time = new Timer("CURRENT TIME", new PVector(CENTER_X - 50, 500), orange_theme);
  
  inRange = new State("IN RANGE", new PVector(CENTER_X - 34, 450), new PVector(75, 50),  green_theme);
  
  port = new Serial(this, Serial.list()[0], 115200);
}
void draw(){
  cursor(ARROW); // can be improve to prevent the pointer twitching
  background(background_color);
  //print(Helper.round_to_nearest(2.051050) + " | ");
  run_button.display();
  reset_button.display();
  edit_button.display();
  
  current_speed_gauge.display();
  max_speed_gauge.display();
  
  current_time.display();
  
  inRange.display();
  
  if(port.available() > 0){
    port.readBytes(data);
  }
  sensor_state = boolean(data[0]);
  text(data[0], 100, 100);

          //// handling events(can improve)\\\\
  if(edit_button.is_toggle() && !run_button.is_active){
    // whenever edit button is active, gauges can be moved 
    current_speed_gauge.area.drag_and_drop();
    max_speed_gauge.area.drag_and_drop();
    current_time.area.drag_and_drop();
    inRange.area.drag_and_drop();
    
    //enable edit button and disable others
    edit_button.is_disabled = false;
    run_button.is_disabled = true;
    reset_button.is_disabled = true;
    
  }else if(run_button.is_toggle() && !edit_button.is_active){ // whenever run button is active, disable edit button
    run_button.is_disabled = false;
    edit_button.is_disabled = true;
                                 //test
    //current_speed_gauge.update_value(int(map(mouseX, 0, width, 0, 51)));
    //max_speed_gauge.update_value(int(map(mouseY, 0, height, 0, 51)));
    inRange.update_state(sensor_state);
    
    if(inRange.state_b){
      counter ++;
      time = (counter / frameRate);
      speed = (distance / time);
      current_time.update_value(time);
      
      //if(time >= 2.99)inRange.update_state(false);
      
      current_speed_gauge.update_value(speed);
    }else counter = 0;
    
  }else{
    // if none are active, set everything to normal
    run_button.is_disabled = false;
    edit_button.is_disabled = false;
    reset_button.is_disabled = false;
    reset_button.is_active = false;
    
    // if run and edit buttons are not active, and reset is clicked
    if(!(run_button.is_active || edit_button.is_active)){
      if(reset_button.is_clicked()){
        //reset all values but before, save everything
                    //test
        max_speed_gauge.update_value(current_speed_gauge.get_value());
        current_speed_gauge.update_value(0);
        current_time.update_value(0);
        inRange.update_state(false);
        
      } else reset_button.is_active = reset_button.is_mouse_over();
    }
  }
}
