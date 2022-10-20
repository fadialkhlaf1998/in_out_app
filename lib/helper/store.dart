import 'package:get/get.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/model/login_info.dart';
import 'package:in_out_app/model/my_date.dart';
import 'package:in_out_app/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static saveLoginInfo(String username,String password)async{
    var prefs = await SharedPreferences.getInstance();
    LoginInfo loginInfo = LoginInfo(username: username, password: password);
    prefs.setString("loginInfo", loginInfo.toJson());
  }

  static Future<LoginInfo?> loadLoginInfo()async{
    var prefs = await SharedPreferences.getInstance();
    String date = prefs.getString("loginInfo")??"null";
    if(date == "null"){
      return null;
    }
    return LoginInfo.fromJson(date);
  }

  static saveState(int state)async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("state", state);
  }

  static Future<int> loadState()async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt("state")??3;
  }

  static saveDate()async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("year", DateTime.now().year);
    prefs.setInt("month", DateTime.now().month);
    prefs.setInt("day", DateTime.now().day);
    Global.myDate = MyDate(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  static Future<MyDate> loadDate()async{
    var prefs = await SharedPreferences.getInstance();
    int year = prefs.getInt("year")??-1;
    int month = prefs.getInt("month")??-1;
    int day = prefs.getInt("day")??-1;
    Global.myDate = MyDate(year, month, day);
    return Global.myDate;
  }
  

  static Future<bool> logout()async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("year");
    prefs.remove("month");
    prefs.remove("day");
    prefs.remove("state");
    prefs.remove("loginInfo");
    //Global.myDate = MyDate(-1, -1, -1);
   // Global.state = 3;
    Global.employee = null;
    Get.offAll(()=>Login());
    return true;
  }

  static bool sameDay() {
    DateTime today = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    print("Hours now : "+DateTime.now().hour.toString());
    print("Today : "+today.toString());
    print("Yesterday : "+yesterday.toString());
    print("day : "+Global.myDate.day.toString());
    print("month : "+Global.myDate.month.toString());
    print("year : "+Global.myDate.year.toString());
    if (
        (Global.myDate.day == today.day &&
        Global.myDate.month == today.month &&
        Global.myDate.year == today.year &&
        DateTime.now().hour >= 8)
            ||
        (Global.myDate.day == yesterday.day &&
        Global.myDate.month == yesterday.month &&
        Global.myDate.year == yesterday.year &&
        DateTime.now().hour < 8)

    ) {
      return true;
    } else {
      return false;
    }
  }
}