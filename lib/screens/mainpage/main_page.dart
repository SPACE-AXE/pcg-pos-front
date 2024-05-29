import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/mainpage/widget/app_bar.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 168,
              child: MyElevatedBtn(
                onPressed: () {
                  Navigator.pushNamed(context, '/carnum');
                },
                text: '차량 입차',
              ),
            )
          ],
        ),
      ),
    );
  }
}
