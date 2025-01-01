PFont baloo_f;
/////////defaults
color background_color = color(236, 241, 241);

color green_color = color(75, 158, 135);
color red_color = color(217, 91, 74);
color orange_color = color(246, 145, 85);
color dark_gray_color = color(80, 90, 92);

color[] green_theme = {green_color, background_color, dark_gray_color};
color[] red_theme = {red_color, background_color, dark_gray_color};
color[] orange_theme = {orange_color, background_color, dark_gray_color};

int size_ratio = 75;
Button run_button;
Button reset_button;
Button edit_button;

Gauge current_speed_gauge;
Gauge max_speed_gauge;

Area2D current_time_area;
Label current_time_label;
Label current_time_value;

void setup(){
  windowTitle("Speed Test");
  size(450, 580);
  baloo_f = createFont("fonts/Baloo2-Medium.ttf", 18); // add font to the font folder in the final application
  textFont(baloo_f);
/////////defaults

  run_button = new Button(new PVector(width/2 - size_ratio/2, 10), new PVector(size_ratio, size_ratio/2), "RUN", green_theme);
  reset_button = new Button(new PVector(width/2 - (size_ratio + (size_ratio*0.5)) - 10, 10), new PVector(size_ratio, size_ratio/2), "RESET", red_theme);
  edit_button = new Button(new PVector(width/2 + (size_ratio - (size_ratio*0.5)) + 10, 10), new PVector(size_ratio, size_ratio/2), "EDIT", orange_theme);
  
  current_speed_gauge = new Gauge("CURRENT SPEED", new PVector(width/2 - 110, height/8), 220, 50, red_theme);
  max_speed_gauge = new Gauge("MAX SPEED", new PVector(width/2 - 80, height/2), 160, 50, green_theme);
  
  //current_time_area = new Area2D(new PVector(20, height - 50), new PVector(100, 50));
  //current_time_label = new Label(current_time_area, "TIME", 18, dark_gray_color);
  //current_time_value = new Label(current_time_area, str(1.54) + "s", 14, red_color);
}
void draw(){
  cursor(ARROW); // can be improve to prevent the pointer twitching
  background(background_color);
  
  run_button.display();
  reset_button.display();
  edit_button.display();
  
  current_speed_gauge.display();
  max_speed_gauge.display();
  
  //current_time_value.update_position(new PVector(current_time_area.position.x, current_time_area.position.y + 20));
  //current_time_value.render();
  //current_time_label.render();
  

  
          /////// handling events(can improve)///////
  if(edit_button.is_toggle() && !run_button.is_active){
    // whenever edit button is active, gauges can be moved 
    current_speed_gauge.area.drag_and_drop();
    max_speed_gauge.area.drag_and_drop();
    
    //enable edit button and disable others
    edit_button.is_disabled = false;
    run_button.is_disabled = true;
    reset_button.is_disabled = true;
    
  }else if(run_button.is_toggle() && !edit_button.is_active){ // whenever run button is active, disable edit button
    run_button.is_disabled = false;
    edit_button.is_disabled = true;
                                 //test
    current_speed_gauge.update_value(int(map(mouseX, 0, width, 0, 51)));
    max_speed_gauge.update_value(int(map(mouseY, 0, height, 0, 51)));
    
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
        current_speed_gauge.update_value(0);
        max_speed_gauge.update_value(0);
        
      } else reset_button.is_active = reset_button.is_mouse_over();
    }
  }
}
