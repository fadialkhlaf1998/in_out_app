import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/model/employee.dart';
import 'package:in_out_app/model/my_date.dart';

class Global {
  static Employee? employee = null;
  static int state = 3;
  static MyDate myDate = MyDate(-1, -1, -1);
  static OverTimeStore overTimeStore = OverTimeStore(inTime: "", outTime: "", in_location: "", out_location: "");

  static List<String> getMonths(){
    List <String> mons = ["1","2","3","4","5","6","7","8",'9','10','11','12'];
    return mons;
  }

  static List<String> getYears(){
    List <String> years = [];
    for(int i = 2022 ; i <= DateTime.now().year; i++){
      years.add(i.toString());
    }
    return years;
  }
}