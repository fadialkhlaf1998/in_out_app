

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/model/workHours.dart';
import 'package:intl/intl.dart';


class WorkHoursController extends GetxController{


  final columns = ['Date', 'In clock', 'Out clock', 'Break in clock', 'Break out clock', 'Overtime in clock', 'Overtime out clock', 'Work hours break'];
  RxList<WorkHour> hoursData = <WorkHour>[].obs;
  var loading = false.obs;
  RxString selectedYear = DateTime.now().year.toString().obs;
  RxString selectedMonth = DateTime.now().month.toString().obs;
  @override
  void onInit(){
    super.onInit();
     getData();
  }

  getData() async {
    loading.value = true;
    await Api.getWorkHours(DateTime.now().year.toString(), DateTime.now().month.toString()).then((value){
      loading.value = false;
      if(value.msg != 'error'){
        hoursData.clear();
        hoursData.addAll(value.workHours);
      }else{
        print('error');
      }
    });
  }


  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
      label: Text(
          column,
        style: const TextStyle(
          color: App.primary
        ),
      )
  )).toList();

  List<DataRow> getRows(List<WorkHour> workHours) => workHours.map((WorkHour workHour){
    final cells = [dateFormat(workHour.date.toString()), workHour.inClock, workHour.outClock,workHour.breakInClock, workHour.breakOutClock, workHour.overTimeInClock, workHour.overTimeOutClock,workHour.workHourBreak];
    return DataRow(cells: getCells(cells),color: workHours.indexOf(workHour)%2 == 0?color1:color2);
  }).toList();

  MaterialStateProperty<Color?> color1 = MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    return Colors.transparent;
  });
  MaterialStateProperty<Color?> color2 = MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    return Colors.white.withOpacity(0.15);
  });
  dateFormat(String old){
    DateTime newDate = DateTime.parse(old);
    return DateFormat('d/M/y').format(newDate).toString();
  }

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text(
          '$data',
        style: const TextStyle(
          color: Colors.white,
        ),
      ))).toList();

  applyFilter(String year, String month) async {
    loading.value = true;
    await Api.getWorkHours(year, month).then((value){
      loading.value = false;
      if(value.msg != 'error'){
        hoursData.clear();
        hoursData.addAll(value.workHours);
      }else{
        print('error-------');
      }
    });
  }

}