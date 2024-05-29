import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pcg_pos/widget/MyElevatedBtn.dart';
import 'package:pcg_pos/screens/mainpage/widget/app_bar.dart';

class NumCheck extends StatefulWidget {
  final String title;

  const NumCheck({
    super.key,
    required this.title,
  });
  @override
  State<NumCheck> createState() => _NumCheckState();
}

class _NumCheckState extends State<NumCheck> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: widget.title),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width * 1,
              height: _isExpanded
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isExpanded
                  ? Container(
                      width: MediaQuery.of(context).size.height * 0.2,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff39c5bb),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: const TextField(
                        maxLength: 8,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          letterSpacing: 20,
                          fontSize: 60,
                        ),
                      ),
                    )
                  : const CarNumber(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyElevatedBtn(
                  text: "아니오",
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                MyElevatedBtn(
                  text: "예",
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                )
              ],
            )
          ],
        ));
  }

  void expandControl() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

class CarNumber extends StatelessWidget {
  const CarNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xff39c5bb),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(2, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.of(context).size.height * 0.40,
      child: const Center(
        child: TextField(
            style: TextStyle(fontSize: 50),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '차량 번호 입력',
            )),
      ),
    );
  }
}
