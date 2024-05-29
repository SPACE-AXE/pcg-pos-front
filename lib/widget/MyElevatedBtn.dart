import 'package:flutter/material.dart';

class MyElevatedBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyElevatedBtn({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        fixedSize: const Size(180, 80),
        backgroundColor: const Color(0xff39c5bb),
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 50),
      ),
    );
  }
}
