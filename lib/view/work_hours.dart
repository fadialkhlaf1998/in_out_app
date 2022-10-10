import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/work_hours_controller.dart';
import 'package:in_out_app/helper/app.dart';
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
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: workHoursController.selectedYear.value,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          dropdownColor: App.primary,
                          items:  Global.getYears().map((items) {
                            return DropdownMenuItem(
                              value: items.toString(),
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            workHoursController.selectedYear.value = newValue.toString();
                          },
                        ),
                        const SizedBox(width: 30),
                        DropdownButton(
                          value: workHoursController.selectedMonth.value,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          dropdownColor: App.primary,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items:  Global.getMonths().map((items) {
                            return DropdownMenuItem(
                              value: items.toString(),
                              child: Text(items.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            workHoursController.selectedMonth.value = newValue.toString();
                          },
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: (){
                            print('-----');
                            workHoursController.applyFilter(workHoursController.selectedYear.value, workHoursController.selectedMonth.value);
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: App.primary,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(
                              child: Text(
                                  'Apply',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
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
                    workHoursController.hoursData.isEmpty
                        ? const Text(
                        'No data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    )
                        : const Text('')
                  ],
                ),
                workHoursController.loading.value ?
                Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ) : const Text(''),
              ],
            ),
          ),
        ),
      );
    });
  }
}
