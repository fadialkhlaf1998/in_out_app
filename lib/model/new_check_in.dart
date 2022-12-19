// To parse this JSON data, do
//
//     final newCheckInDecoder = newCheckInDecoderFromMap(jsonString);

import 'package:in_out_app/model/new_checkin_details.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class NewCheckInDecoder {
  NewCheckInDecoder({
    required this.newCheckin,
    required this.newCheckinDetails,
  });

  List<NewCheckin> newCheckin;
  List<NewCheckinDetail> newCheckinDetails;

  factory NewCheckInDecoder.fromJson(String str) => NewCheckInDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewCheckInDecoder.fromMap(Map<String, dynamic> json) => NewCheckInDecoder(
    newCheckin: List<NewCheckin>.from(json["new_checkin"].map((x) => NewCheckin.fromMap(x))),
    newCheckinDetails: List<NewCheckinDetail>.from(json["new_checkin_details"].map((x) => NewCheckinDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "new_checkin": List<dynamic>.from(newCheckin.map((x) => x.toMap())),
    "new_checkin_details": List<dynamic>.from(newCheckinDetails.map((x) => x.toMap())),
  };
}

class NewCheckin {
  NewCheckin({
    required this.id,
    required this.inLocation,
    required this.inDateTime,
    required this.outDateTime,
    required this.outLocation,
    required this.note,
    required this.employeeId,
    required this.duration,
    required this.companyId,
    required this.day,
    required this.inDate,
    required this.outDate,
    required this.inTime,
    required this.outTime,
    required this.employee,
  });

  int id;
  String inLocation;
  DateTime inDateTime;
  DateTime? outDateTime;
  String outLocation;
  String note;
  int employeeId;
  double duration;
  int companyId;
  String day;
  String inDate;
  String outDate;
  String inTime;
  String outTime;
  String employee;

  factory NewCheckin.fromJson(String str) => NewCheckin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewCheckin.fromMap(Map<String, dynamic> json) => NewCheckin(
    id: json["id"],
    inLocation: json["in_location"],
    inDateTime: DateTime.parse(json["in_date_time"]),
    outDateTime: json["out_date_time"]==null?null:DateTime.parse(json["out_date_time"]),
    outLocation: json["out_location"]==null?"":json["out_location"],
    note: json["note"]==null?"":json["note"],
    employeeId: json["employee_id"],
    duration: json["duration"]==null?0:json["duration"].toDouble(),
    companyId: json["company_id"],
    day: json["day"],
    inDate: json["in_date"],
    outDate: json["out_date"]==null?"":json["out_date"],
    inTime: json["in_time"],
    outTime: json["out_time"]==null?"":json["out_time"],
    employee: json["employee"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "in_location": inLocation,
    "in_date_time": inDateTime.toIso8601String(),
    "out_date_time": outDateTime!.toIso8601String(),
    "out_location": outLocation,
    "note": note,
    "employee_id": employeeId,
    "duration": duration,
    "company_id": companyId,
    "day": day,
    "in_date": inDate,
    "out_date": outDate,
    "in_time": inTime,
    "out_time": outTime,
    "employee": employee,
  };
}
