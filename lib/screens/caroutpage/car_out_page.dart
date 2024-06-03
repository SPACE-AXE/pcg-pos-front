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
  int? _parkingTime;
  int? _parkingAmount;
  int? _chargeCapacity;
  int? _chargeAmount;
  int? _totalAmount;

  @override
  void initState() {
    super.initState();
    _calculateEntryTime();
    _calculateAmount();
  }

  void _calculateEntryTime() {
    final entryTime = DateTime.parse(widget.carData.entryTime)
        .add(const Duration(hours: -9))
        .toLocal();
    final currentTime = DateTime.now();
    final difference = currentTime.difference(entryTime);
    setState(() {
      _parkingTime = difference.inMinutes;
    });
  }

  void _calculateAmount() {
    setState(() {
      _parkingAmount = _parkingTime != null ? _parkingTime! * 100 : 0;
      _chargeAmount = widget.carData.chargeAmount ?? 0;
      _chargeCapacity = ((_chargeAmount! / 10) as double?)?.toInt() ?? 0;
      _totalAmount = (_parkingAmount ?? 0) + (_chargeAmount ?? 0);
    });
  }

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
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 6,
              child: Container(
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
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.carData.carNum,
                        style: const TextStyle(
                          fontSize: 60,
                        ),
                      ),
                      QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: qrSize,
                      ),
                      const SizedBox(height: 16),
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
                        child: const Text(
                          '출차 확인',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 6,
              child: Container(
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
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow('주차시간',
                          _parkingTime != null ? '$_parkingTime분' : '계산 중...'),
                      const SizedBox(height: 16),
                      _buildRow(
                          '주차요금',
                          _parkingAmount != null
                              ? '$_parkingAmount원'
                              : '계산 중...'),
                      const SizedBox(height: 32),
                      _buildRow(
                          '충전량',
                          _chargeCapacity != null
                              ? '${_chargeCapacity}kWh'
                              : '계산 중...'),
                      const SizedBox(height: 16),
                      _buildRow(
                          '충전요금',
                          _chargeAmount != null
                              ? '$_chargeAmount원'
                              : '계산 중...'),
                      const SizedBox(height: 32),
                      _buildRow('총요금',
                          _totalAmount != null ? '$_totalAmount원' : '계산 중...',
                          isTotal: true),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String left, String right, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '$left:',
              style: TextStyle(
                fontSize: isTotal ? 50 : 35,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '  $right',
              style: TextStyle(
                fontSize: isTotal ? 50 : 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
