class TimeUtils {
  static int getHourFromTime(String time) {
    String hour = time.substring(0, time.indexOf(':'));
    return int.parse(hour);
  }

  static int getMinuteFromTime(String time) {
    String minute = time.substring(time.indexOf(':') + 1);    
    return int.parse(minute);
  }
}