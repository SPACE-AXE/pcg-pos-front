import 'package:flutter/material.dart';
import 'package:pcg_pos/screens/numchkpage/widget/animation_container.dart';

class NumberCheckPage extends StatelessWidget {
  final String title;

  const NumberCheckPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
