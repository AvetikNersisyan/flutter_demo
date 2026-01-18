
class Utils {
  static String getFirstLetter(String value) {
    if(value.isEmpty) return "";
    final chars = value.substring(0,1);
    return chars.toUpperCase();
  }
}