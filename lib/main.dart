// ignore_for_file: unused_import

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:pcg_pos/screens/mainpage/main_page.dart';
import 'package:pcg_pos/screens/numinpage/number_input_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String appTitle = 'Park-Charge-Go POS';
  late IO.Socket socket;
  static const String _baseUrl = 'http://localhost:3000';

  @override
  void initState() {
    super.initState();
    socket = IO.io(_baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('connected to the server');
    });

    socket.on('disconnect', (reason) {
      print('disconnected: $reason');
    });

    socket.on('error', (error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: appTitle,
        socket: socket,
      ),
    );
  }
}
