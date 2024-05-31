import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numinpage/widget/keypad.dart';

class NumKeypad extends StatefulWidget {
  final Function(String) addCarnum;
  final Function() deleteCarNum;
  const NumKeypad(
      {super.key, required this.addCarnum, required this.deleteCarNum});

  @override
  _NumKeypadState createState() => _NumKeypadState();
}

class _NumKeypadState extends State<NumKeypad> {
  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', const Icon(Icons.keyboard_backspace)],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
