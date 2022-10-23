

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/model/workHours.dart';
import 'package:intl/intl.dart';


class WorkHoursController extends GetxController{


  final inOutColumns = ['Date', 'In', 'Out'];
  RxList<WorkHour> hoursData = <WorkHour>[].obs;
  RxList<OverTime> overTime = <OverTime>[].obs;
  var loading = false.obs;
  RxString selectedYear = DateTime.now().year.toString().obs;
  RxString selectedMonth = DateTime.now().month.toString().obs;

  RxString selectedYearOldData = DateTime.now().year.toString().obs;
  RxString selectedMonthOldData = DateTime.now().month.toString().obs;
  RxBool inOutButton = true.obs;
  RxBool inOutBreakButton = false.obs;
  RxBool inOutOvertimeButton = false.obs;
  RxInt optionNumber = 1.obs;


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
        overTime = value.overTime.obs;
        print('overTimeLength'+ overTime.length.toString());
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

  List<DataRow> getRows(List<WorkHour> workHours, option,List<OverTime> overTime) =>
      option == 3 ?
      overTime.map((OverTime elm){
        final cells =  [dateFormat(elm.date.toString()), elm.in_time, elm.out_time];

        return DataRow(cells: getCells(cells),color: overTime.indexOf(elm) % 2 == 0 ? color1 : color2);
      }).toList()

      :workHours.map((WorkHour workHour){
    final cells = option == 1
        ? [dateFormat(workHour.date.toString()), workHour.inClock, workHour.outClock]
        : [dateFormat(workHour.date.toString()), workHour.breakInClock, workHour.breakOutClock];

    return DataRow(cells: getCells(cells),color: workHours.indexOf(workHour) % 2 == 0 ? color1 : color2);
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
        selectedMonthOldData.value = month;
        selectedYearOldData.value = year;
        hoursData.clear();
        hoursData.addAll(value.workHours);
        overTime = value.overTime.obs;
        print('overTimeLength'+ overTime.length.toString());
      }else{
        print('error-------');
      }
    });
  }

}