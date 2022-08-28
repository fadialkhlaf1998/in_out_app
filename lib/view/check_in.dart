import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/controller/intro_controller.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';

class CheckIn extends StatelessWidget {

  CheckInController checkInController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CheckIn")),
      body: SafeArea(
        child: Obx(() => Container(
            width: MediaQuery.of(context).size.width,
            child: checkInController.loading.value?Center(
              child: CircularProgressIndicator(),
            ): Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: statesView(context),
              ),
            )
        ),)
      ),
    );
  }

  statesView(BuildContext context){
    if(Global.state == 3 && Global.myDate.day != DateTime.now().day
        && Global.myDate.month != DateTime.now().month && Global.myDate.year != DateTime.now().year ){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          inView(context),
        ],
      );
    }else if(Global.state == 0){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          breakInView(context),
          breakOutView(context),
          outView(context),
        ],
      );
    }else if(Global.state == 1){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          breakOutView(context),
          outView(context),
        ],
      );
    }else if(Global.state == 1){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          outView(context),
        ],
      );
    }else{
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          Text("You Cannot In More Than One Time Ber Day")
        ],
      );
    }
  }

  inView(BuildContext context){
    return GestureDetector(
      onTap: (){
        Store.saveDate();
        checkInController.checkIn(0);
      },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: Text("In",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }

  breakInView(BuildContext context){
    return GestureDetector(
        onTap: (){
          checkInController.checkIn(1);
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: Text("Break In",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }

  breakOutView(BuildContext context){
    return GestureDetector(
        onTap: (){
          checkInController.checkIn(2);
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: Text("Break Out",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }

  outView(BuildContext context){
    return GestureDetector(
        onTap: (){
          checkInController.checkIn(3);
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: Text("Out",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }
}
