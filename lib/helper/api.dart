import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/model/employee.dart';

class Api {
  static String url = "https://phpstack-548447-2849982.cloudwaysapps.com/";
  // static String url = "http://10.0.2.2:3000";
  static String token="";

  static Future<Employee?> login(String username,String password)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/employee/login'));
    request.body = json.encode({
      "username": username,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonData = await response.stream.bytesToString();
      EmployeeDecoder temp = EmployeeDecoder.fromJson(jsonData);
      token = temp.employee.token;
      Global.employee = temp.employee;
      Store.saveLoginInfo(username, password);
      return temp.employee;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<bool> checkIn(int state,String location)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/check-in'));
    request.body = json.encode({
      "employee_id": Global.employee!.id,
      "company_id": Global.employee!.companyId,
      "state": state,
      "mobile_date_time": DateTime.now().toString(),
      "location": location
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Store.saveState(state);
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }
}