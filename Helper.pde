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
}
