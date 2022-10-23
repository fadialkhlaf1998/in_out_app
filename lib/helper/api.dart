import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/model/day_person.dart';
import 'package:in_out_app/model/employee.dart';
import 'package:in_out_app/model/workHours.dart';

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
      print(jsonData);
      EmployeeDecoder temp = EmployeeDecoder.fromJson(jsonData);
      token = temp.employee.token;
      Global.employee = temp.employee;
      Global.myDate = temp.employee.getMyDate();
      Global.state = temp.employee.state;
      Store.saveLoginInfo(username, password);
      return temp.employee;
    }
    else {
      print(response.reasonPhrase);
      return null;
    }
  }

  static Future<bool> checkIn(int state,String location,DateTime dateTime)async{
    var headers = {
      'Authorization': 'Bearer '+token,
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'/api/check-in'));
    request.body = json.encode({
      "employee_id": Global.employee!.id,
      "company_id": Global.employee!.companyId,
      "state": state,
      "mobile_date_time": dateTime.toString(),
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


  static Future<List<DayPerson>> getAppList()async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+token,
    };
    var request = http.Request('POST', Uri.parse(url+'/api/check-in/app-list'));
    DateTime today = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime date = DateTime.now().hour < 8?yesterday:today;
    request.body = json.encode({
      "company_id": Global.employee!.companyId,
      "year": date.year,
      "month": date.month,
      "day": date.day
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = (await response.stream.bytesToString());
      // print(data);
      DayPersonDecoder dayPersonDecoder = DayPersonDecoder.fromJson(data);
      return dayPersonDecoder.dayPeople;
    }
    else {
      print(response.reasonPhrase);
      String data = (await response.stream.bytesToString());
      log(data);
      return <DayPerson>[];
    }
  }

  static Future changePassword(String id, String newPassword) async {
    var headers = {
      'Authorization': 'Barear ${Global.employee!.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url + 'api/employee/change-password'));
    request.body = json.encode({
      "id": id,
      "new_password": newPassword
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<WorkHoursDecoder> getWorkHours(String year, String month) async {
    var headers = {
      'Authorization': 'Barear ${Global.employee!.token}',
    };
    var request = http.Request('GET', Uri.parse(url + 'api/check-in/data/${Global.employee!.id}/$year/$month'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonData = await response.stream.bytesToString();
      var data = json.decode(jsonData);
      WorkHoursDecoder workHoursDecoder =  WorkHoursDecoder.fromMap(data);
      workHoursDecoder . msg = "";
      return workHoursDecoder;
    }
    else {
      WorkHoursDecoder workHoursDecoder =  WorkHoursDecoder(workHours: <WorkHour>[],overTime: <OverTime>[]);
      workHoursDecoder . msg = "error";
      return workHoursDecoder;

    }
  }

  static Future changeImage(File image) async {
    var headers = {
      'Authorization': 'Barear ${Global.employee!.token}',
    };
    var request = http.MultipartRequest('PUT', Uri.parse(url + 'api/employee/change-image'));
    request.fields.addAll({
      'id': Global.employee!.id.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('files', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<bool> overTime()async{
    var headers = {
      'Authorization': 'Bearer ${Global.employee!.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'api/over-time'));
    request.body = json.encode({
      "employee_id": Global.employee!.id,
      "company_id": Global.employee!.companyId,
      "out_location": Global.overTimeStore.out_location,
      "in_location": Global.overTimeStore.in_location,
      "mobile_date_time_in": Global.overTimeStore.inTime,
      "mobile_date_time_out": Global.overTimeStore.outTime
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Store.clearOverTime();
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }

  }

}