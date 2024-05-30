import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numchkpage/widget/animation_container.dart';
import 'package:pcg_pos/widget/toggle_app_bar.dart';

class NumberCheckPage extends StatefulWidget {
  final String title;

  const NumberCheckPage({
    super.key,
    required this.title,
  });

  @override
  State<NumberCheckPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NumberCheckPage> {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const NumCheck(
                title: 'Park-Charge-Go POS',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
