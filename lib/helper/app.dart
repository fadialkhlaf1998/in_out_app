import 'package:get/get.dart';
import 'package:flutter/material.dart';
class App{

  static succMsg(String title,String message){
    Get.snackbar(title, message,backgroundColor: Colors.blue,colorText: Colors.white);
  }

  static errMsg(String title,String message){
    Get.snackbar(title, message,backgroundColor: Colors.red,colorText: Colors.white);
  }
}