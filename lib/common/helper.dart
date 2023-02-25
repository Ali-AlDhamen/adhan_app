class Helper {
  static String getFormattedTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String getFormattedTimeAMPM(String time) {
    var timeSplit = time.split(':');
    var hour = int.parse(timeSplit[0]);
    var minute = int.parse(timeSplit[1]);
    var ampm = 'AM';
    if (hour > 12) {
      hour = hour - 12;
      ampm = 'PM';
    }

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $ampm';
  }

  static int getDifferenceInSeconds(String time1, String time2) {
    var time1Split = time1.split(':');
    var time2Split = time2.split(':');
    var time1Hour = int.parse(time1Split[0]);
    var time1Minute = int.parse(time1Split[1]);
    var time2Hour = int.parse(time2Split[0]);
    var time2Minute = int.parse(time2Split[1]);
    var time1Seconds = time1Hour * 3600 + time1Minute * 60;
    var time2Seconds = time2Hour * 3600 + time2Minute * 60;
    return time2Seconds - time1Seconds;
  }



  static String getFormattedTimeFromSeconds(int seconds) {
    var hour = (seconds / 3600).floor();
    var minute = ((seconds % 3600) / 60).floor();
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static DateTime getDateTimeFromFormattedTime(String time) {
    var timeSplit = time.split(':');
    var hour = int.parse(timeSplit[0]);
    var minute = int.parse(timeSplit[1]);
    DateTime now =  DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }


}