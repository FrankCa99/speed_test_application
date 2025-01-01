class State{
  private Area2D area;
  private Label name_l;
 
  private color base_color;
  private int font_size = 16;
  
  public boolean state_b = false;
  
  State(String name_s, PVector position_v, PVector size_v, color[] color_arr){
    area = new Area2D(position_v, size_v);
    name_l = new Label(area, name_s, font_size, color_arr[0]);
    base_color = color_arr[0];
  }
  public void display(boolean debug){ // useful for debuging the interactiva area
    if(debug)area.wire_render();
    display();
  }
  public void display(){
    if(state_b){
      noStroke();
      fill(base_color);
    }else{
      noFill();
      strokeWeight(2);
      stroke(base_color);
    }
    circle(area.position.x + area.size.x/2, area.position.y + area.size.y/3, (area.size.x + area.size.y) / 4);
    
    name_l.update_position(new PVector(area.position.x, area.position.y + area.size.y / 3));
    name_l.render();
  }
  public void update_state(boolean new_state_b){
    state_b = new_state_b;
  }
  public boolean is_toggle(){ 
    if(area.is_mouse_clicked())state_b = !state_b;
    return state_b; 
  }
}
