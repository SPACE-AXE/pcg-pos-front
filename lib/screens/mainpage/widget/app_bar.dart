import 'package:flutter/material.dart';
import 'package:pcg_pos/widget/cur_time.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff39c5bb),
      title: Text(title),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
      actions: [
        Builder(
          builder: (context) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CurrentTime(),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
