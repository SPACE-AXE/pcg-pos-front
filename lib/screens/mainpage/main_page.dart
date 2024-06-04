// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numinpage/number_input_page.dart';
import 'package:pcg_pos/widget/toggle_app_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  final String title;
  final IO.Socket socket;

  const MyHomePage({
    super.key,
    required this.title,
    required this.socket,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isEntry = true;

  void _toggleEntryExit() {
    setState(() {
      _isEntry = !_isEntry;
    });
  }

  void _navigateToNumberInputPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NumberInputPage(
          title: widget.title,
          isEntry: _isEntry,
          socket: widget.socket,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imagePath1 = 'assets/images/pcg_icon.png';
    String imagePath2 = 'assets/images/pcg_logo_miku.png';
    String imagePath3 = 'assets/images/pcg_logo_black.png';
    double imageWidth = MediaQuery.of(context).size.width * 0.4;
    double imageHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      appBar: MyToggleAppBar(
        title: widget.title,
        isEntry: _isEntry,
        onToggle: _toggleEntryExit,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 6,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        imagePath3,
                        width: imageWidth,
                        height: imageHeight,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          fixedSize: const Size(400, 120),
                          backgroundColor: const Color(0xff39c5bb),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: _navigateToNumberInputPage,
                        child: Text(
                          _isEntry ? '차량 입차' : '차량 출차',
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xff39c5bb),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(2, 6),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '금오공과대학교 주차장',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '(시연용)',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 48),
                      _buildRow(
                        '주차요금',
                        '1분',
                      ),
                      const SizedBox(height: 16),
                      _buildRow(
                        '회원',
                        '100원',
                      ),
                      const SizedBox(height: 32),
                      _buildRow(
                        '충전요금',
                        '1kWh',
                      ),
                      const SizedBox(height: 16),
                      _buildRow(
                        '회원',
                        '10원',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String left, String right, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '$left |',
              style: TextStyle(
                fontSize: isTotal ? 50 : 35,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '  $right',
              style: TextStyle(
                fontSize: isTotal ? 50 : 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
