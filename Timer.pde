class Timer{
  private Area2D area;
  private Label name_l;
  private Label value_l;
  
  private int font_size = 16;
  private int size_offset = 20;
  
  private float value = 0;
  
  Timer(String name_s, PVector position_v, color[] color_arr){
    area = new Area2D(position_v, new PVector(textWidth(name_s), font_size + size_offset * 2));
    name_l = new Label(area, name_s, font_size, color_arr[0]);
    value_l = new Label(area, str(0) + " sec", font_size, color_arr[2]);
  }
  public void display(boolean debug){ // useful for debuging the interactiva area
    if(debug)area.wire_render();
    display();
  }
  public void display(){
    value_l.update_position(new PVector(area.position.x, area.position.y + area.size.y - (font_size + size_offset)));
    name_l.update_position(area.position);
    
    value_l.update_text((value));
    
    name_l.render();
    value_l.render();    
  }
  public void update_value(float new_value_i){
    value = new_value_i;
  }
}
