import 'package:get/get.dart';
import 'package:flutter/material.dart';
class App{

  static const primary = Color(0xFF72be05);
  static const navyBlue = Color(0xFF1a2a36);

  static succMsg(String title,String message){
    Get.snackbar(title, message,
        backgroundColor: primary,colorText: Colors.white);
  }

  static errMsg(String title,String message){
    Get.snackbar(title, message,
        backgroundColor: Colors.red,colorText: Colors.white);
  }

  static int getHr(String data){
    return int.parse(data.split(":")[0]);
  }

  static int getMin(String data){
    return int.parse(data.split(":")[1]);
  }
}