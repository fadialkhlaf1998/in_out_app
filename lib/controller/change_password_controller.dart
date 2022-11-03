import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';


class ChangePasswordController extends GetxController{

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool showPassword1 = true.obs;
  RxBool showPassword2 = true.obs;

  RxBool validate = false.obs;

  saveNewPassword(){
    print(Global.employee!.password);
    if(oldPassword.text.isEmpty || newPassword.text.isEmpty || confirmPassword.text.isEmpty){
      validate.value = true;
    }else if(oldPassword.text != Global.employee!.password){
      App.errMsg('Wrong!', 'The old password does not match your password');
    }else if(newPassword.text != confirmPassword.text){
      App.errMsg('Wrong!', 'Password not confirmed');
    }else{
      validate.value = true;
      FocusManager.instance.primaryFocus?.unfocus();
      Api.changePassword(Global.employee!.id.toString(), newPassword.text).then((value){
        if(value){
          Get.back();
          Store.saveLoginInfo(Global.employee!.username, newPassword.text);
          App.succMsg('Success', 'Password changed successfully');

        }else{
          App.errMsg('Wrong!', 'Something went wrong');
        }
      });
    }
  }

}