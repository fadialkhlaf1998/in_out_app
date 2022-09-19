import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/model/employee.dart';
import 'package:in_out_app/view/check_in.dart';

class LoginController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var loading = false.obs;
  var validate = false.obs;
  var showPassword = true.obs;

  login()async{
    if(username.text.isEmpty||password.text.isEmpty){
      validate.value = true;
    }else{
      loading.value = true;
      Employee? employee = await Api.login(username.text, password.text);
      loading.value = false;
      if(employee!=null){
        Get.offAll(()=>CheckIn());
        App.succMsg("Login", "Login Has Been Successfully");
      }else{
        App.succMsg("Login", "Oops Wrong Username or Password");
      }
    }
  }
}