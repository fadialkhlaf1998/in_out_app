import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/work_hours_controller.dart';
import 'package:in_out_app/helper/global.dart';

class WorkHours extends StatelessWidget {

  WorkHoursController workHoursController = Get.put(WorkHoursController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/new_icons/background.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: SafeArea(
            child: Column(
              children: [
                DropdownButton(
                  value: workHoursController.selectedYear.toString(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items:  Global.getYears().map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    workHoursController.selectedYear = newValue.toString();
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.white.withOpacity(0.3)),
                      columns: workHoursController.getColumns(workHoursController.columns),
                      rows: workHoursController.getRows(workHoursController.hoursData),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
