import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class App{

  static const primary = Color(0xFF72be05);
  static const navyBlue = Color(0xFF1a2a36);
  static Color opacity = Color(0xFFD6D6D8).withOpacity(0.9);
  static Color smallBtnBG = Color(0xff5A7A92).withOpacity(0.72);
  // static Color smallBtn = Color(0xFFD6D6D8).withOpacity(0.1);

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
  
  static Loading(){
    return Center(
      child: Lottie.asset("assets/Loading.json",width: 100,height: 100),
    );
  }
}