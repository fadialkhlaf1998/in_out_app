import 'dart:convert';

class LoginInfo {
  LoginInfo({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory LoginInfo.fromJson(String str) => LoginInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginInfo.fromMap(Map<String, dynamic> json) => LoginInfo(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
  };
}
