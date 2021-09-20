class TimeUtils {
  static int getHourFromTime(String time) {
    String hour = time.substring(0, time.indexOf(':'));
    return int.parse(hour);
  }

  static int getMinuteFromTime(String time) {
    String minute = time.substring(time.indexOf(':') + 1);
    return int.parse(minute);
  }

  static Duration dateTimeToDuration(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime addOneDay = now.add(Duration(days: 1));
    bool isBefore = dateTime.isBefore(now);
    var diff = isBefore
        ? DateTime.now().difference(addOneDay)
        : DateTime.now().difference(dateTime);
    return Duration(minutes: diff.inMinutes.abs());
  }
}
