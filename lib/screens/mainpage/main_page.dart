import 'package:flutter/material.dart';
import 'package:pcg_pos/widget/app_bar.dart';
import 'package:pcg_pos/widget/MyElevatedBtn.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  bool _isEntry = true;

  @override
  void initState() {
    super.initState();
    _pages = [
      // 여기에 페이지 목록을 추가하세요.
    ];
  }

  void _toggleEntryExit() {
    setState(() {
      _isEntry = !_isEntry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        isEntry: _isEntry,
        onToggle: _toggleEntryExit,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 168,
              child: MyElevatedBtn(
                onPressed: () {
                  Navigator.pushNamed(context, '/carnum');
                },
                text: _isEntry ? '차량 입차' : '차량 출차',
              ),
            )
          ],
        ),
      ),
    );
  }
}
