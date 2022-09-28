// To parse this JSON data, do
//
//     final dayPersonDecoder = dayPersonDecoderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DayPersonDecoder {
  DayPersonDecoder({
    required this.dayPeople,
  });

  List<DayPerson> dayPeople;

  factory DayPersonDecoder.fromJson(String str) => DayPersonDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DayPersonDecoder.fromMap(Map<String, dynamic> json) => DayPersonDecoder(
    dayPeople: List<DayPerson>.from(json["day_people"].map((x) => DayPerson.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "day_people": List<dynamic>.from(dayPeople.map((x) => x.toMap())),
  };
}

class DayPerson {
  DayPerson({
    required this.date,
    required this.employee,
    required this.image,
    required this.inHour,
    required this.outHour,
    required this.inClock,
    required this.inLocation,
    required this.breakInClock,
    required this.breakInLocation,
    required this.breakOutClock,
    required this.breakOutLocation,
    required this.outClock,
    required this.outLocation,
    required this.overTimeInClock,
    required this.overTimeInLocation,
    required this.overTimeOutClock,
    required this.overTimeOutLocation,
    required this.dayPersonBreak,
  });

  DateTime date;
  String employee;
  String image;
  String inHour;
  String outHour;
  String inClock;
  String? inLocation;
  String? breakInClock;
  String? breakInLocation;
  String? breakOutClock;
  String? breakOutLocation;
  String? outClock;
  String? outLocation;
  String? overTimeInClock;
  String? overTimeInLocation;
  String? overTimeOutClock;
  String? overTimeOutLocation;
  String? dayPersonBreak;

  factory DayPerson.fromJson(String str) => DayPerson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DayPerson.fromMap(Map<String, dynamic> json) => DayPerson(
    date: DateTime.parse(json["date"]),
    employee: json["employee"],
    image: json["image"],
    inHour: json["in_hour"],
    outHour: json["out_hour"],
    inClock: json["in_clock"],
    inLocation: json["in_location"],
    breakInClock: json["break_in_clock"],
    breakInLocation: json["break_in_location"],
    breakOutClock: json["break_out_clock"],
    breakOutLocation: json["break_out_location"],
    outClock: json["out_clock"],
    outLocation: json["out_location"],
    overTimeInClock: json["over_time_in_clock"],
    overTimeInLocation: json["over_time_in_location"],
    overTimeOutClock: json["over_time_out_clock"],
    overTimeOutLocation: json["over_time_out_location"],
    dayPersonBreak: json["break"],
  );

  Map<String, dynamic> toMap() => {
    "date": date.toIso8601String(),
    "employee": employee,
    "image": image,
    "in_hour": inHour,
    "out_hour": outHour,
    "in_clock": inClock,
    "in_location": inLocation,
    "break_in_clock": breakInClock,
    "break_in_location": breakInLocation,
    "break_out_clock": breakOutClock,
    "break_out_location": breakOutLocation,
    "out_clock": outClock,
    "out_location": outLocation,
    "over_time_in_clock": overTimeInClock,
    "over_time_in_location": overTimeInLocation,
    "over_time_out_clock": overTimeOutClock,
    "over_time_out_location": overTimeOutLocation,
    "break": dayPersonBreak,
  };

  String getState(){
    if(overTimeOutClock != null){
      return "Overtime-Out";
    }else if(overTimeInClock != null){
      return "Overtime-IN";
    }else if(outClock != null){
      return "Check-Out";
    }else if(breakOutClock != null){
      return "break-Out";
    }else if(breakInClock != null){
      return "break-In";
    }
    return "Check-IN";
  }

  String getClock(){
    if(overTimeOutClock != null){
      return overTimeOutClock!;
    }else if(overTimeInClock != null){
      return overTimeInClock!;
    }else if(outClock != null){
      return outClock!;
    }else if(breakOutClock != null){
      return breakOutClock!;
    }else if(breakInClock != null){
      return breakInClock!;
    }
    return inClock;
  }


  String getDescription(){
    if(overTimeOutClock != null){
      return "Overtime-Out";
    }else if(overTimeInClock != null){
      return "Overtime-IN";
    }else if(outClock != null){
      return "I Finished My Work";
    }else if(breakOutClock != null){
      return "I'm Done With The Break Now";
    }else if(breakInClock != null){
      return "Now He Is In The Break";
    }
    return "I Started Working";
  }


}
