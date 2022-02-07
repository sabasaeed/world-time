class TimeHelper {
  static String getTimeOfDay(DateTime now) {
    return now.hour > 6 && now.hour < 19 ? "Morning" : "Night";
  }

  static bool isDayTime(DateTime now) {
    return now.hour > 6 && now.hour < 19 ? true : false;
  }
}
