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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          HeaderButton(
                              width: 100,
                              height: 30,
                              radius: 10,
                              onTap: (){
                                workHoursController.optionNumber.value = 1;
                              },
                              press: workHoursController.optionNumber.value == 1 ? true : false,
                              title: 'In/Out',
                          ),
                          HeaderButton(
                            width: 100,
                            height: 30,
                            radius: 10,
                            onTap: (){
                              workHoursController.optionNumber.value = 2;
                            },
                            press: workHoursController.optionNumber.value == 2 ? true : false,
                            title: 'Break',
                          ),
                          HeaderButton(
                            width: 100,
                            height: 30,
                            radius: 10,
                            onTap: (){
                              workHoursController.optionNumber.value = 3;
                            },
                            press: workHoursController.optionNumber.value == 3 ? true : false,
                            title: 'OverTime',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: (){
                    //     Get.back();
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 22),
                    //   ),
                    // ),
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
                    inOutTable(workHoursController.optionNumber.value),
                  ],
                ),
                workHoursController.loading.value
                    ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : const Text(''),
              ],
            ),
          ),
        ),
      );
    });
  }

  inOutTable(int option){
    var columns = workHoursController.inOutColumns;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(color: Colors.white.withOpacity(0.3)),
              columns: workHoursController.getColumns(columns),
              rows: workHoursController.getRows(workHoursController.hoursData,option),
            ),
          ),
        ),
        workHoursController.hoursData.isEmpty && workHoursController.loading.isFalse
            ? const Text(
              'No data',
              style: TextStyle(
              color: Colors.white,
              fontSize: 16
              ),
            )
            :
        const Text('')
      ],
    );
  }



}

class HeaderButton extends StatelessWidget {

  double width;
  double height;
  double radius;
  VoidCallback onTap;
  bool press;
  String title;


  HeaderButton({
    required this.width,
    required this.height,
    required this.radius,
    required this.onTap,
    required this.press,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: press ? App.primary : Colors.transparent,
          border: press ? null : Border.all(width: 1, color: App.primary)
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: press ? Colors.white : App.primary,
              fontWeight: press ? FontWeight.bold : FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}

