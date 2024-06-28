import 'package:brightinfotech_new_project/modules/Scanned%20Card%20Details/scannedcarddetails.dart';
import 'package:brightinfotech_new_project/modules/reminder/reminderpage.dart';
import 'package:brightinfotech_new_project/modules/scannedcardslist/scannedcardslist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      home: scannedcardslist()
    );
  }}