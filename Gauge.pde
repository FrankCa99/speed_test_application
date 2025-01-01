class Gauge{
  
  public Area2D area; // interactive area
  private Label current_value_label, min_value_label, max_value_label, name_label; // all the text utilized by this class
  
  private int current_value, max_value, label_size = 48; // initial font sise. 
  private color arc_color, reference_arc_color; // colors
  
  Gauge(String name_s, PVector position_v, int size_i, int max_i, color[] color_arr){
    area = new Area2D(position_v, new PVector(size_i, size_i/2)); // create the area
    
    label_size = size_i / 4; // dynamic font size dependig on area
    
    max_value = max_i; // max value the gauge can display being min value 0
    current_value = max_value / 2; // actual value the gauge that is displaying
    
    current_value_label = new Label(area, str(current_value), label_size, color_arr[0]); // label for the current value
    min_value_label = new Label(area, str(0), label_size / 2, color_arr[0]); // label for the min value
    max_value_label = new Label(area, str(max_value), label_size / 2, color_arr[0]); // label for the max value
    name_label = new Label(area, name_s, label_size / 3, color_arr[2]); // label for the name of the data you are currently displaying
    
    arc_color = color_arr[0]; // color for the gauge arc
    reference_arc_color = color_arr[2]; // color for the reference arc
  }
  public void display(boolean debug){ // useful for debuging the interactiva area
    if(debug)area.wire_render();
    display();
  }
  public void display(){ 
    //area.position = new PVector(mouseX, mouseY); // improvement later
    //area.drag_and_drop();
    //
    int arc_value = int(map(current_value, 0, max_value, 0, 180)); // map the gauge value to use for the arc
    
    int arc_px = int(area.position.x + (area.size.x/2)); // get the center of the area horizontally
    int arc_py = int(area.position.y + (area.size.y)); // get the center of the area vertically
    
    noFill();
    //reference arc display
    strokeWeight(1);
    stroke(reference_arc_color);
    arc(arc_px, arc_py, area.size.x, area.size.y*2, radians(180), radians(360), OPEN);
    //current arc display
    strokeWeight(label_size/6);
    stroke(arc_color);
    arc(arc_px, arc_py, area.size.x, area.size.y*2, radians(180), radians(180+arc_value), OPEN);
    
    //area.update_cursor(); // see area for more
    
    // update all label position
    current_value_label.update_position(new PVector(area.position.x, area.position.y + label_size/2));
    min_value_label.update_position(new PVector(area.position.x - label_size*1.5, area.position.y + label_size));
    max_value_label.update_position(new PVector(area.position.x + label_size*1.5, area.position.y + label_size));
    name_label.update_position(new PVector(area.position.x, area.position.y + label_size*1.5));
    
    current_value_label.update_text(str(current_value)); // change the gauge label text to the actual gauge value
    
    // display all the labels
    current_value_label.render();
    min_value_label.render();
    max_value_label.render();
    name_label.render();
    
  }
  public void update_position(PVector new_position_v){ // change the position of the gauge
    area.position = new_position_v;
  }
  public void update_value(int new_value_i){ // update the gauge value
    current_value = new_value_i;
  }
}
