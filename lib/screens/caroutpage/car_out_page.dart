// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pcg_pos/car_data.dart';
import 'package:pcg_pos/services/pos_api.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pcg_pos/widget/app_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CarOutPage extends StatefulWidget {
  final String title;
  final CarData carData;
  final IO.Socket socket;

  const CarOutPage({
    super.key,
    required this.title,
    required this.carData,
    required this.socket,
  });

  @override
  State<CarOutPage> createState() => _CarOutPageState();
}

class _CarOutPageState extends State<CarOutPage> {
  Future<void> _outParking() async {
    bool success =
        await ApiService.outParking(widget.carData.carNum, widget.socket);

    if (success) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('성공'),
            content: const Text('차량이 성공적으로 출차되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      // 요청이 실패했음을 나타내는 팝업 표시
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('실패'),
            content: const Text('차량이 출차되지 않았습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String qrData = '{"paymentId": "${widget.carData.paymentId}"}';
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
                    widget.carData.carNum,
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
                    onPressed: () async {
                      await _outParking();
                    },
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
