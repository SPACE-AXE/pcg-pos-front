import 'package:flutter/material.dart';
import 'package:pcg_pos/widget/MyElevatedBtn.dart';

class CarNumPage extends StatelessWidget {
  const CarNumPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 168,
              child: MyElevatedBtn(
                text: "123",
              ),
            )
          ],
        ),
      ),
    );
  }
}
