class Label{
  private PVector position; // corner position
  
  private float width_i, height_i;
  
  private String text_s;
  private int font_size;
  private color label_color;
  
  Label(Area2D area_a, String label_s, int size_i, color color_c){
    update_position(area_a.position);
    
    width_i = area_a.size.x; 
    height_i = area_a.size.y;
    
    font_size = size_i;
    label_color = color_c;
    
    update_text(label_s);
  }
  public void update_text_color(color new_color_c){ //well what you expect XD
    label_color = new_color_c;
  }
  public void update_text(String new_label_t){ // update the text
    text_s = new_label_t;
  }
  public void update_text(float new_label_t){ // update the text
    update_text(str(Helper.round_to_nearest(new_label_t)));
  }
  public void update_position(PVector position_v){ // update the corner position
    position = position_v;
  }
  public void render(){
    textSize(font_size); // set the font size 
    fill(label_color); // set the font color
    
    float label_x = position.x + (width_i/2) - (textWidth(text_s)/2); // find the center horizontally
    float label_y = position.y + (height_i / 2) + (font_size/4); // find the center vertically
    
    text(text_s, label_x, label_y); // display the text
    
    textSize(18); // restore to default font size
  }
}
