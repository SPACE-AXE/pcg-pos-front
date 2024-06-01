import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pcg_pos/widget/app_bar.dart';

class CarOutPage extends StatefulWidget {
  final String title;
  final String carNum;

  const CarOutPage({
    super.key,
    required this.title,
    required this.carNum,
  });

  @override
  State<CarOutPage> createState() => _CarOutPageState();
}

class _CarOutPageState extends State<CarOutPage> {
  final String paymentId = "76164a21-8eb7-4de0-ae1e-df88f43647c7";

  @override
  Widget build(BuildContext context) {
    String qrData = '{"paymentId": "$paymentId"}';
    double qrSize = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      appBar: MyAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 차량번호 입력
                  Text(
                    widget.carNum,
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 16),
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: qrSize,
                  ),
                  SizedBox(height: 16),
                  // 출차 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      fixedSize: const Size(300, 60),
                      backgroundColor: const Color(0xff39c5bb),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      '출차 확인',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // Right side
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주차시간: 00분', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 16),
                  Text('주차요금: 00원', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 32),
                  Text('충전량: 00kWh', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 16),
                  Text('충전요금: 00원', style: TextStyle(fontSize: 30)),
                  SizedBox(height: 32),
                  Text('총요금: 00원', style: TextStyle(fontSize: 40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
