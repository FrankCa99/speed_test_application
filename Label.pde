class Label{
  private PVector position; // corner position
  
  private float width_i, height_i;
  
  private String label_text;
  private int label_font_size;
  private color label_color;
  
  Label(Area2D area, String label_t, int size_i, color color_c){
    update_position(area.position);
    
    width_i = area.size.x; 
    height_i = area.size.y;
    
    label_font_size = size_i;
    label_color = color_c;
    
    update_text(label_t);
  }
  public void update_text_color(color new_color_c){ //well what you expect XD
    label_color = new_color_c;
  }
  public void update_text(String new_label_t){ // update the text
    label_text = new_label_t;
  }
  public void update_position(PVector position_v){ // update the corner position
    position = position_v;
  }
  public void render(){
    textSize(label_font_size); // set the font size 
    fill(label_color); // set the font color
    
    float label_x = position.x + (width_i/2) - (textWidth(label_text)/2); // find the center horizontally
    float label_y = position.y + (height_i / 2) + (label_font_size/4); // find the center vertically
    
    text(label_text, label_x, label_y); // display the text
    
    textSize(18); // restore to default font size
  }
}
