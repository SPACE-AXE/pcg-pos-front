// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pcg_pos/car_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:pcg_pos/screens/caroutpage/car_out_page.dart';
import 'package:pcg_pos/screens/numinpage/widget/keypad_container.dart';
import 'package:pcg_pos/widget/toggle_app_bar.dart';
import 'package:pcg_pos/services/pos_api.dart';

class NumberInputPage extends StatefulWidget {
  final String title;
  final bool isEntry;
  final IO.Socket socket;

  const NumberInputPage({
    super.key,
    required this.title,
    required this.isEntry,
    required this.socket,
  });

  @override
  State<NumberInputPage> createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  late bool _isEntry;

  final List<String> initials = [
    'ㄱ',
    'ㄲ',
    'ㄴ',
    'ㄷ',
    'ㄸ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅃ',
    'ㅅ',
    'ㅆ',
    'ㅇ',
    'ㅈ',
    'ㅉ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  final List<String> vowels = [
    'ㅏ',
    'ㅐ',
    'ㅑ',
    'ㅒ',
    'ㅓ',
    'ㅔ',
    'ㅕ',
    'ㅖ',
    'ㅗ',
    'ㅘ',
    'ㅙ',
    'ㅚ',
    'ㅛ',
    'ㅜ',
    'ㅝ',
    'ㅞ',
    'ㅟ',
    'ㅠ',
    'ㅡ',
    'ㅢ',
    'ㅣ'
  ];
  String carNum = '';
  final int baseCode = 0xAC00;

  @override
  void initState() {
    super.initState();
    _isEntry = widget.isEntry;
  }

  void _toggleEntryExit() {
    setState(() {
      _isEntry = !_isEntry;
    });
  }

  void addCarNum(String value) {
    if (value == 'ㅏ' || value == 'ㅓ' || value == 'ㅗ' || value == 'ㅜ') {
      final tmp = carNum.substring(carNum.length - 1);
      carNum = carNum.substring(0, carNum.length - 1);
      int initialIndex = initials.indexOf(tmp);
      int vowelIndex = vowels.indexOf(value);

      int unicode = baseCode + (initialIndex * 21 * 28) + (vowelIndex * 28);
      setState(() {
        carNum += String.fromCharCode(unicode);
      });
    } else {
      setState(() {
        carNum += value;
      });
    }
    debugPrint("마지막문자:${carNum.substring(carNum.length - 1)}");
  }

  void deleteCarNum() {
    setState(() {
      carNum = carNum.substring(0, carNum.length - 1);
    });
    debugPrint(carNum);
  }

  Future<void> _sendCarNum() async {
    bool success = await ApiService.sendCarNum(carNum, widget.socket);

    if (success) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('성공'),
            content: const Text('차량이 성공적으로 입차되었습니다.'),
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
            content: const Text('차량이 입차되지 않았습니다.'),
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

  Future<void> _checkParking() async {
    int statuscode = await ApiService.checkParking(carNum, widget.socket);

    if (statuscode == 403) {
      CarData myData = await ApiService.getUnpaid(carNum, widget.socket);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CarOutPage(
            title: widget.title,
            carData: myData,
            socket: widget.socket,
          ),
        ),
      );
    } else if (statuscode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('성공'),
            content: const Text('차량이 사전정산 되었습니다.'),
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
            content: const Text('차량을 출차할 수 없습니다.'),
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
    return Scaffold(
      appBar: MyToggleAppBar(
        title: widget.title,
        isEntry: _isEntry,
        onToggle: _toggleEntryExit,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 3,
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Text(
                      carNum,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Consumer(
                  builder: (context, ref, child) {
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
                      onPressed: () async {
                        _isEntry ? await _sendCarNum() : _checkParking();
                      },
                      child: Text(
                        _isEntry ? '입차' : '출차',
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  },
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          KeypadContainer(addCarNum: addCarNum, deleteCarNum: deleteCarNum),
        ],
      ),
    );
  }
}
