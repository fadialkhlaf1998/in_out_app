import 'dart:convert';

WorkHoursDecoder workHoursDecoderFromMap(String str) => WorkHoursDecoder.fromMap(json.decode(str));

String workHoursDecoderToMap(WorkHoursDecoder data) => json.encode(data.toMap());

class WorkHoursDecoder {
  WorkHoursDecoder({
    required this.workHours,
    required this.overTime
  });
  List<OverTime> overTime;
  List<WorkHour> workHours;
  String msg="";

  factory WorkHoursDecoder.fromMap(Map<String, dynamic> json) => WorkHoursDecoder(
    workHours: List<WorkHour>.from(json["work_hours"].map((x) => WorkHour.fromMap(x))),
    overTime: List<OverTime>.from(json["over_time"].map((x) => OverTime.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "work_hours": List<dynamic>.from(workHours.map((x) => x.toMap())),
    "over_time": List<dynamic>.from(overTime.map((x) => x.toMap())),
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


class OverTime {
  OverTime({
    required this.date,
    required this.employee,
    required this.id,
    required this.employeeId,
    required this.companyId,
    required this.createdAt,
    required this.mobileDateTimeIn,
    required this.mobileDateTimeOut,
    required this.inLocation,
    required this.outLocation,
    required this.in_time,
    required this.out_time,
  });

  DateTime date;
  String employee;
  String in_time;
  String out_time;
  int id;
  int employeeId;
  int companyId;
  DateTime createdAt;
  DateTime mobileDateTimeIn;
  DateTime mobileDateTimeOut;
  String inLocation;
  String outLocation;

  factory OverTime.fromJson(String str) => OverTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OverTime.fromMap(Map<String, dynamic> json) => OverTime(
    date: DateTime.parse(json["date"]),
    employee: json["employee"],
    id: json["id"],
    employeeId: json["employee_id"],
    in_time: json["in_time"],
    out_time: json["out_time"],
    companyId: json["company_id"],
    createdAt: DateTime.parse(json["created_at"]),
    mobileDateTimeIn: DateTime.parse(json["mobile_date_time_in"]),
    mobileDateTimeOut: DateTime.parse(json["mobile_date_time_out"]),
    inLocation: json["in_location"],
    outLocation: json["out_location"],
  );

  Map<String, dynamic> toMap() => {
    "date": date.toIso8601String(),
    "employee": employee,
    "id": id,
    "employee_id": employeeId,
    "company_id": companyId,
    "created_at": createdAt.toIso8601String(),
    "mobile_date_time_in": mobileDateTimeIn.toIso8601String(),
    "mobile_date_time_out": mobileDateTimeOut.toIso8601String(),
    "in_location": inLocation,
    "out_location": outLocation,
  };
}

