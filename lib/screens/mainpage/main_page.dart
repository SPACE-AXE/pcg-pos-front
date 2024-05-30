import 'package:flutter/material.dart';
import 'package:pcg_pos/widget/toggle_app_bar.dart';
import 'package:pcg_pos/widget/MyElevatedBtn.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
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
