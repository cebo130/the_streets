import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getVerboseDateTimeRepresentation(DateTime dateTime) {
  DateTime now = DateTime.now().toLocal();

  DateTime localDateTime = dateTime.toLocal();

  if (localDateTime.difference(now).inDays == 0) {
    var differenceInHours = localDateTime.difference(now).inHours.abs();
    var differenceInMins = localDateTime.difference(now).inMinutes.abs();

    if (differenceInHours > 0) {
      return '$differenceInHours hours ago';
    } else if (differenceInMins > 2) {
      return '$differenceInMins mins ago';
    }
    else {
      return 'Just now';
    }
  }

  String roughTimeString = DateFormat('jm').format(dateTime);

  if (localDateTime.day == now.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return roughTimeString;
  }

  DateTime yesterday = now.subtract(const Duration(days: 1));

  if (localDateTime.day == yesterday.day &&
      localDateTime.month == now.month &&
      localDateTime.year == now.year) {
    return 'Yesterday';
  }

  if (now.difference(localDateTime).inDays < 4) {
    String weekday = DateFormat(
      'EEEE',
    ).format(localDateTime);

    return '$weekday, $roughTimeString';
  }

  return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';
}