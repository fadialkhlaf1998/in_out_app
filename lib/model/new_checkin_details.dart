// To parse this JSON data, do
//
//     final newCheckInDeatilsDecoder = newCheckInDeatilsDecoderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class NewCheckInDeatilsDecoder {
  NewCheckInDeatilsDecoder({
    required this.newCheckinDetails,
  });

  List<NewCheckinDetail> newCheckinDetails;

  factory NewCheckInDeatilsDecoder.fromJson(String str) => NewCheckInDeatilsDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewCheckInDeatilsDecoder.fromMap(Map<String, dynamic> json) => NewCheckInDeatilsDecoder(
    newCheckinDetails: List<NewCheckinDetail>.from(json["new_checkin_details"].map((x) => NewCheckinDetail.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "new_checkin_details": List<dynamic>.from(newCheckinDetails.map((x) => x.toMap())),
  };
}

class NewCheckinDetail {
  NewCheckinDetail({
    required this.day,
    required this.duration,
    required this.workHours,
  });

  String day;
  double duration;
  double workHours;

  factory NewCheckinDetail.fromJson(String str) => NewCheckinDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewCheckinDetail.fromMap(Map<String, dynamic> json) => NewCheckinDetail(
    day: json["day"],
    duration: json["duration"]==null?0:json["duration"].toDouble(),
    workHours: json["work_hours"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "day": day,
    "duration": duration,
    "work_hours": workHours,
  };
}
