import 'package:in_out_app/model/employee.dart';
import 'package:in_out_app/model/my_date.dart';

class Global {
  static Employee? employee = null;
  static int state = 3;
  static MyDate myDate = MyDate(-1, -1, -1);
}