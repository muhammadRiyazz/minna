 String changetime({required String time}) {
    final int tim = int.parse(time);
    int journeyDay = tim ~/ (24 * 60);
    int remainingTime = tim % (24 * 60);
    int hour = remainingTime ~/ 60;
    int minutes = remainingTime % 60;

    String timePeriod = hour >= 12 ? 'P.M' : 'A.M';
    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;

    return '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $timePeriod';
  }