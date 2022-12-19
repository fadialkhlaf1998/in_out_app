

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/model/new_check_in.dart';
import 'package:in_out_app/model/new_checkin_details.dart';
import 'package:in_out_app/model/workHours.dart';
import 'package:intl/intl.dart';


class WorkHoursController extends GetxController{


  final inOutColumns = ['Date', 'In', 'Out'];
  final detailsColumns = ['Date', 'Work', 'OverTime','Total'];
  RxList<NewCheckin> checkin = <NewCheckin>[].obs;
  RxList<NewCheckinDetail> checkinDetails = <NewCheckinDetail>[].obs;
  var loading = false.obs;
  RxString selectedYear = DateTime.now().year.toString().obs;
  RxString selectedMonth = DateTime.now().month.toString().obs;

  RxString selectedYearOldData = DateTime.now().year.toString().obs;
  RxString selectedMonthOldData = DateTime.now().month.toString().obs;
  RxBool inOutButton = true.obs;
  RxBool inOutBreakButton = false.obs;
  RxBool inOutOvertimeButton = false.obs;
  RxInt optionNumber = 0.obs;


  @override
  void onInit(){
    super.onInit();
     getData();
  }

  getData() async {
    loading.value = true;
    await Api.getEmployeeCheckinList(DateTime.now().month.toString(), DateTime.now().year.toString()).then((value){
      loading.value = false;
      checkin = value.newCheckin.obs;
      checkinDetails = value.newCheckinDetails.obs;
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

  List<DataRow> getRows(List<NewCheckin> newcheckin, option,List<NewCheckinDetail> newcheckindetails) =>
      option == 1 ?
      newcheckindetails.map((NewCheckinDetail elm){
        final cells =  [
          elm.day.toString(),
          elm.duration > elm.workHours ?elm.workHours.toStringAsFixed(2):elm.duration.toStringAsFixed(2),
          elm.duration > elm.workHours ?(elm.duration - elm.workHours).toStringAsFixed(2):0,
          elm.duration.toStringAsFixed(2)
        ];
        return DataRow(cells: getCells(cells),color: newcheckindetails.indexOf(elm) % 2 == 0 ? color1 : color2);
      }).toList()

      :newcheckin.map((NewCheckin newCheckinelm){
    final cells = [newCheckinelm.day.toString(), newCheckinelm.inTime, newCheckinelm.outTime];

    return DataRow(cells: getCells(cells),color: newcheckin.indexOf(newCheckinelm) % 2 == 0 ? color1 : color2);
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
    await Api.getEmployeeCheckinList(month, year).then((value){
      loading.value = false;
      selectedMonthOldData.value = month;
      selectedYearOldData.value = year;

      checkin = value.newCheckin.obs;
      checkinDetails = value.newCheckinDetails.obs;

    });
  }

}