import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelman/utils/colors.dart';

final _firestore = FirebaseFirestore.instance;
final String collectionDbName = 'instagram_stories_db';
final storiesRef = _firestore.collection(collectionDbName);
final usersRef = _firestore.collection('users');

const kToken = '*****';
const kInputDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kPinBlue,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

String formatOnlyDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy').format(dateTime);
}

String formatDate(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
}

String formatHour(DateTime dateTime) {
  if (dateTime == null) {
    return ' ';
  }
  return DateFormat('HH:mm').format(dateTime);
}

String readTimeStamp(DateTime date) {
  var format = new DateFormat.Hm(); // My Format 08:00

  return format.format(date);
}
