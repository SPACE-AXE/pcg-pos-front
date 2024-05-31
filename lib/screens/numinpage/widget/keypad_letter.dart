// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numinpage/widget/keypad.dart';

class LetKeypad extends StatefulWidget {
  final Function(String) addCarnum;
  final Function() deleteCarNum;
  const LetKeypad(
      {super.key, required this.addCarnum, required this.deleteCarNum});

  @override
  _LetKeypadState createState() => _LetKeypadState();
}

class _LetKeypadState extends State<LetKeypad> {
  final keys = [
    ['ㄱ', 'ㄴ', 'ㄷ', 'ㅏ', 'ㅓ'],
    ['ㄹ', 'ㅁ', 'ㅂ', 'ㅗ', 'ㅜ'],
    ['ㅅ', 'ㅇ', 'ㅈ', '', ''],
    ['', '', '', '', const Icon(Icons.keyboard_backspace)],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff39c5bb),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: keys
            .map(
              (x) => Row(
                children: x.map((y) {
                  return Expanded(
                    child: MyKeyPad(
                      label: y,
                      onTap: (val) {
                        val is Widget
                            ? widget.deleteCarNum()
                            : widget.addCarnum(val);
                      },
                      value: y,
                    ),
                  );
                }).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
