import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numinpage/widget/keypad_letter.dart';
import 'package:pcg_pos/screens/numinpage/widget/keypad_number.dart';

class KeypadContainer extends StatefulWidget {
  final Function(String) addCarNum;
  final Function() deleteCarNum;
  const KeypadContainer(
      {super.key, required this.addCarNum, required this.deleteCarNum});

  @override
  State<KeypadContainer> createState() => _KeypadContainerState();
}

class _KeypadContainerState extends State<KeypadContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LetKeypad(
            addCarnum: widget.addCarNum, deleteCarNum: widget.deleteCarNum),
        // VowelsKeyboard(setCarNum: widget.setCarNum),
        NumKeypad(
            addCarnum: widget.addCarNum, deleteCarNum: widget.deleteCarNum),
      ],
    );
  }
}
