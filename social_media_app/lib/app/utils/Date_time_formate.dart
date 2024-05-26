import 'package:flutter/material.dart';

class MyDateUtil {
  // for getting formatted time from milliSecondsSinceEpochs String
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final int? milliseconds = _parseMilliseconds(time);
    if (milliseconds == null) return 'Invalid time';

    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return TimeOfDay.fromDateTime(date).format(context);
  }

  // for getting formatted time for sent & read
  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final int? milliseconds = _parseMilliseconds(time);
    if (milliseconds == null) return 'Invalid time';

    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }

  //get last message time (used in chat user card)
  static String getLastMessageTime(
      {required BuildContext context,
        required String time,
        bool showYear = false}) {
    final int? milliseconds = _parseMilliseconds(time);
    if (milliseconds == null) return 'Invalid time';

    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final DateTime now = DateTime.now();

    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    return showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}';
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int? milliseconds = _parseMilliseconds(lastActive);
    if (milliseconds == null) return 'Last seen not available';

    final DateTime time = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final DateTime now = DateTime.now();

    final String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return formattedTime;
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return '1 day ago';
    }

    final String month = _getMonth(time);
    return '${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'NA';
    }
  }

  // helper method to parse milliseconds string to int
  static int? _parseMilliseconds(String time) {
    try {
      return int.parse(time);
    } catch (e) {
      return null;
    }
  }
}
