import 'package:get/get.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
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
    checkInController.alwaysUpdateScreen();
    getDate();
  }
  getDate()async{
    await Future.delayed(Duration(milliseconds: 1200));
    LoginInfo? loginInfo = await Store.loadLoginInfo();
    await Store.loadDate();
    if(loginInfo !=null){
      Employee? emp = await Api.login(loginInfo.username, loginInfo.password);

      if(emp!=null){
        // Global.myDate = emp.getMyDate();
        // Global.state = emp.state;
        // print(Global.state);
        // print("Global.state");
        // print(emp.date);
        print(Store.sameDay());

        if(!Store.sameDay()&&Global.state<3&&emp.date.isNotEmpty){
          var date =DateTime.parse(emp.date);
          var out = DateTime(date.year,date.month,date.day,App.getHr(emp.out_hour),App.getMin(emp.out_hour),0);
          await checkInController.checkInWithDate(3, out);
        }
        print('----------HERE----------');
        Get.off(()=>CheckIn());
      }else{
        Get.off(()=>Login());
      }
    }else{
      Get.off(()=>Login());
    }
  }
}