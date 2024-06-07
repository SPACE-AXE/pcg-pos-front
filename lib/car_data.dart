import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CarData {
  final int id;
  final String entryTime;
  final String? exitTime;
  final String? chargeStartTime;
  final int? chargeTime;
  final String? paymentTime;
  final int? chargeAmount;
  final int? parkingAmount;
  final int? totalAmount;
  final String carNum;
  final bool isPaid;
  final String paymentId;

  CarData({
    required this.id,
    required this.entryTime,
    required this.exitTime,
    required this.chargeStartTime,
    required this.chargeTime,
    required this.paymentTime,
    required this.chargeAmount,
    required this.parkingAmount,
    required this.totalAmount,
    required this.carNum,
    required this.isPaid,
    required this.paymentId,
  });

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      id: json['id'],
      entryTime: json['entryTime'],
      exitTime: json['exitTime'],
      chargeStartTime: json['chargeStartTime'],
      chargeTime: json['chargeTime'],
      paymentTime: json['paymentTime'],
      chargeAmount: json['chargeAmount'],
      parkingAmount: json['parkingAmount'],
      totalAmount: json['totalAmount'],
      carNum: json['carNum'],
      isPaid: json['isPaid'],
      paymentId: json['paymentId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'entryTime': entryTime,
        'exitTime': exitTime,
        'chargeStartTime': chargeStartTime,
        'chargeTime': chargeTime,
        'paymentTime': paymentTime,
        'chargeAmount': chargeAmount,
        'parkingAmount': parkingAmount,
        'totalAmount': totalAmount,
        'carNum': carNum,
        'isPaid': isPaid,
        'paymentId': paymentId,
      };
}
