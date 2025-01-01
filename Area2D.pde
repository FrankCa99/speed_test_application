class Area2D{
  PVector position, size; // corner position and size
  PVector last_mouse_position;
  PVector last_position;
  
  private boolean is_clicked = false;
  
  Area2D(PVector position_v, PVector size_v){
    position = position_v;
    last_mouse_position = new PVector();
    size = size_v;
  }
  private boolean is_point_inside(PVector point){
   return Helper.is_point_inside(point.x, point.y, position.x, position.y, size.x, size.y); 
  }
  public boolean is_mouse_over(){
   return is_point_inside(new PVector(mouseX, mouseY));
  }
  public boolean is_mouse_down(){
    return (mousePressed && is_mouse_over());
  }
  
  public boolean is_mouse_clicked(){
    if(is_mouse_down() && !is_clicked){
      is_clicked = true;
      return true;
    }else if(!is_mouse_down())is_clicked = false;
    return false;
  }
  public void update_cursor(){
    if(is_mouse_over())cursor(HAND);
  }
  public void drag_and_drop(){
    if(!is_mouse_down()){
      last_mouse_position.set(mouseX, mouseY);
      last_position = position;
    }else position = last_position.copy().add((new PVector(mouseX, mouseY).sub(last_mouse_position)));
    wire_render();
    update_cursor();
  }
  public void wire_render(){
    fill(4, 104, 255, 25);
    strokeWeight(1);
    stroke(4, 104, 255);
    rect(position.x, position.y, size.x, size.y);
  }
}
