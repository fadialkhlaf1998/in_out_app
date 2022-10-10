import 'dart:convert';

WorkHoursDecoder workHoursDecoderFromMap(String str) => WorkHoursDecoder.fromMap(json.decode(str));

String workHoursDecoderToMap(WorkHoursDecoder data) => json.encode(data.toMap());

class WorkHoursDecoder {
  WorkHoursDecoder({
    required this.workHours,
  });

  List<WorkHour> workHours;
  String msg="";

  factory WorkHoursDecoder.fromMap(Map<String, dynamic> json) => WorkHoursDecoder(
    workHours: List<WorkHour>.from(json["work_hours"].map((x) => WorkHour.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "work_hours": List<dynamic>.from(workHours.map((x) => x.toMap())),
  };
}

class WorkHour {
  WorkHour({
    required this.date,
    // required this.employee,
    // required this.inHour,
    // required this.outHour,
    required this.inClock,
    // required this.inLocation,
    required this.breakInClock,
    // required this.breakInLocation,
    required this.breakOutClock,
    // required this.breakOutLocation,
    required this.outClock,
    // required this.outLocation,
    required this.overTimeInClock,
    // required this.overTimeInLocation,
    required this.overTimeOutClock,
    // required this.overTimeOutLocation,
    required this.workHourBreak,
  });

  DateTime date;
  // String employee;
  // String inHour;
  // String outHour;
  String inClock;
  // String inLocation;
  String breakInClock;
  // String breakInLocation;
  String breakOutClock;
  // String breakOutLocation;
  String outClock;
  // String outLocation;
  String overTimeInClock;
  // String overTimeInLocation;
  String overTimeOutClock;
  // String overTimeOutLocation;
  String workHourBreak;

  factory WorkHour.fromMap(Map<String, dynamic> json) => WorkHour(
    date: DateTime.parse(json["date"]),
    // employee: json["employee"],
    // inHour: json["in_hour"],
    // outHour: json["out_hour"],
    inClock: json["in_clock"] ?? "",
    // inLocation: json["in_location"],
    breakInClock: json["break_in_clock"] ?? "",
    // breakInLocation: json["break_in_location"],
    breakOutClock: json["break_out_clock"]?? "",
    // breakOutLocation: json["break_out_location"],
    outClock: json["out_clock"]?? "",
    // outLocation: json["out_location"],
    overTimeInClock: json["over_time_in_clock"]?? "",
    // overTimeInLocation: json["over_time_in_location"],
    overTimeOutClock: json["over_time_out_clock"]?? "",
    // overTimeOutLocation: json["over_time_out_location"],
    workHourBreak: json["break"]?? "",
  );

  Map<String, dynamic> toMap() => {
    "date": date.toIso8601String(),
    // "employee": employee,
    // "in_hour": inHour,
    // "out_hour": outHour,
    "in_clock": inClock,
    // "in_location": inLocation,
    "break_in_clock": breakInClock,
    // "break_in_location": breakInLocation,
    "break_out_clock": breakOutClock,
    // "break_out_location": breakOutLocation,
    "out_clock": outClock,
    // "out_location": outLocation,
    "over_time_in_clock": overTimeInClock,
    // "over_time_in_location": overTimeInLocation,
    "over_time_out_clock": overTimeOutClock,
    // "over_time_out_location": overTimeOutLocation,
    "break": workHourBreak,
  };
}
