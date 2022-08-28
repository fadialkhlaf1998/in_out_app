import 'package:get/get.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/model/employee.dart';
import 'package:in_out_app/model/login_info.dart';
import 'package:in_out_app/view/check_in.dart';
import 'package:in_out_app/view/login.dart';

class IntroController extends GetxController{

  CheckInController checkInController = Get.put(CheckInController());

  @override
  void onInit() {
    super.onInit();
    getDate();
  }
  getDate()async{
    LoginInfo? loginInfo = await Store.loadLoginInfo();
    await Store.loadDate();
    if(loginInfo !=null){
      Employee? emp = await Api.login(loginInfo.username, loginInfo.password);
      if(emp!=null){
        Global.state = await Store.loadState();
        Get.off(()=>CheckIn());
      }else{
        Get.off(()=>Login());
      }
    }else{
      Get.off(()=>Login());
    }
  }
}