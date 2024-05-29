// ignore_for_file: unused_import

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pcg_pos/screens/carnumpage/car_num_page.dart';
import 'package:pcg_pos/screens/mainpage/main_page.dart';
import 'package:pcg_pos/screens/numchkpage/number_check_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appTitle = 'Park-Charge-Go POS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: appTitle),
        '/carnum': (context) => NumberCheckPage(title: appTitle),
      },
    );
  }
}
