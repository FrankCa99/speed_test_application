class Button{
  private Area2D area;
  private Label label;
  
  private int radius = 5; // corner radius
  private int label_size = 18; // size of the font(hard coded?)
  private color background_color;
  private color label_text_color;
  private color disabled_state_color;
  
  public boolean is_active = false;
  public boolean is_disabled = false;
  
  Button(PVector position_v, PVector size_v, String label_t, color[] color_arr){
    area = new Area2D(position_v, size_v); // interactive area
    label = new Label(area, label_t, label_size, color_arr[1]); // make a new label with all its attributes
    background_color = color_arr[0]; // the background color
    label_text_color = color_arr[1];
    disabled_state_color = color_arr[2];
  }
  public void display(){ // display the element with its width and height along with its text
    if(is_active){
      strokeWeight(1);
      noFill();
      stroke(background_color);
      label.update_text_color(background_color);
    }else if(is_disabled){
      noStroke();
      fill(disabled_state_color); // self explanatory
      label.update_text_color(label_text_color);
    }else{
      noStroke();
      fill(background_color); // self explanatory
      label.update_text_color(label_text_color); 
    }
    rect(area.position.x, area.position.y, area.size.x, area.size.y, radius); // create the button visual area
    
    //area.update_cursor(); // change from arrow to pointer, classic user experience
    label.render(); // display the label in the center
  }
  public void display(boolean debug){ // helpful if you want to debug user interactions
    if(debug) area.wire_render();
    display();
  }
  public boolean is_toggle(){ 
    if(area.is_mouse_clicked() && !is_disabled)is_active = !is_active;
    return is_active; 
  }
  public boolean is_clicked(){
    return area.is_mouse_clicked();
  }
  public boolean is_mouse_over(){
    return area.is_mouse_over();
  }
}
