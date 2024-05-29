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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pcg_pos_front',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Park-Charge-Go POS'),
        '/carnum': (context) =>
            const NumberCheckPage(title: 'Park-Charge-Go POS'),
      },
    );
  }
}
