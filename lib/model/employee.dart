// To parse this JSON data, do
//
//     final employeeDecoder = employeeDecoderFromMap(jsonString);

import 'dart:convert';

class EmployeeDecoder {
  EmployeeDecoder({
    required this.employee,
  });

  Employee employee;

  factory EmployeeDecoder.fromJson(String str) => EmployeeDecoder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeDecoder.fromMap(Map<String, dynamic> json) => EmployeeDecoder(
    employee: Employee.fromMap(json["employee"]),
  );

  Map<String, dynamic> toMap() => {
    "employee": employee.toMap(),
  };
}

class Employee {
  Employee({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.companyId,
    required this.token,
    required this.in_hour,
    required this.out_hour,
  });

  int id;
  String username;
  String password;
  String name;
  int companyId;
  String token;
  String in_hour;
  String out_hour;


  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    name: json["name"],
    companyId: json["company_id"],
    token: json["token"],
    in_hour: json["in_hour"],
    out_hour: json["out_hour"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "name": name,
    "company_id": companyId,
    "token": token,
  };
}
