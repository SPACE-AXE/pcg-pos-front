import 'package:flutter/material.dart';

class MyKeyPad extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const MyKeyPad({
    super.key,
    required this.label,
    required this.onTap,
    required this.value,
  })  : assert(label != null),
        assert(value != null);

  @override
  _MyKeyPadState createState() => _MyKeyPadState();
}

class _MyKeyPadState extends State<MyKeyPad> {
  renderLabel() {
    if (widget.label is String) {
      return Text(
        widget.label,
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return widget.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Container(
          child: Center(
            child: renderLabel(),
          ),
        ),
      ),
    );
  }
}
