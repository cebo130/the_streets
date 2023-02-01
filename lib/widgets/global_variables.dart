import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String myUserName = "";
Widget build(BuildContext context) {
  return new StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        var userDocument = snapshot.data!;
        myUserName = userDocument["username"];
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        return new Text(userDocument["username"]);
      });
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + 'h';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + 'm';
    } else if (diff.inSeconds > 0) {
      time = 'now';
    } else if (diff.inMilliseconds > 0) {
      time = 'now';
    } else if (diff.inMicroseconds > 0) {
      time = 'now';
    } else {
      time = 'now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = diff.inDays.toString() + 'd';
  } else if (diff.inDays > 6) {
    time = (diff.inDays / 7).floor().toString() + 'w';
  } else if (diff.inDays > 29) {
    time = (diff.inDays / 30).floor().toString() + 'm';
  } else if (diff.inDays > 365) {
    time = '${date.month} ${date.day}, ${date.year}';
  }
  return time;
}

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final duration = now.difference(date);

  if (duration.inSeconds < 60) {
    return '${duration.inSeconds} seconds ago';
  } else if (duration.inMinutes < 60) {
    return '${duration.inMinutes} minutes ago';
  } else if (duration.inHours <= 1) {
    return '${duration.inHours} hour ago';
  } else if (duration.inHours < 24) {
    return '${duration.inHours} hours ago';
  } else if (duration.inDays <= 1) {
    return '${duration.inDays} day ago';
  } else if (duration.inDays < 7) {
return '${duration.inDays} days ago';
} else if (duration.inDays < 31) {
    return '${(duration.inDays / 7).floor()} week(s) ago';
  } else if (duration.inDays > 31) {
return '${(duration.inDays / 31).floor()} month(s) ago';
} else {
    return date.toString();
  }
}
