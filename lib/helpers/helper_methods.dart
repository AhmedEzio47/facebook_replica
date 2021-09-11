import 'package:intl/intl.dart';

String formatTimestamp(DateTime? date) {
  if (date == null) return '';
  var now = DateTime.now();

  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 60) {
    time = 'now';
  } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
    time = '${diff.inMinutes}m';
  } else if (diff.inHours > 0 && diff.inHours < 24) {
    time = '${diff.inHours}h';
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = '${diff.inDays}d';
  } else {
    if (diff.inDays >= 7 && diff.inDays < 14) {
      time = '1w';
    } else {
      time = '${DateFormat('MMM dd, yyyy').format(date)}';
    }
  }

  return time;
}
