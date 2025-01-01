static class Helper{
  // n = number to be tested
  static boolean is_in_range(float n, float min, float max){
    return n > min && n < max;
  }
  // p? = point to be tested
  // s? = top left point
  // e? = bottom right point
  static boolean is_point_inside(float px, float py, float sx, float sy, float ex, float ey){
    return (is_in_range(px, sx, sx + ex) && is_in_range(py, sy, sy + ey));
  }
  static float degrees_to_radians(int degrees){
    return degrees * PI / 180;
  }
  static float round_to_nearest(float n){
    String[] sides = split(str(n), ".");
    String right_side = sides[1];
    String second;
    if(right_side.length() > 2)second = ""+right_side.charAt(1);
    else second = "0";
    return float(sides[0] +"."+ right_side.charAt(0) + second);
  }
}
