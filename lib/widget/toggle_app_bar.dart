import 'package:flutter/material.dart';
import 'package:pcg_pos/widget/cur_time.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isEntry;
  final VoidCallback onToggle;

  const MyAppBar({
    super.key,
    required this.title,
    required this.isEntry,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff39c5bb),
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 30)),
      centerTitle: false,
      actions: [
        Builder(
          builder: (context) {
            return const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CurrentTime(),
            );
          },
        ),
      ],
      flexibleSpace: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ToggleButtons(
            isSelected: [isEntry, !isEntry],
            onPressed: (index) {
              onToggle();
            },
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('입차',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('출차',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
