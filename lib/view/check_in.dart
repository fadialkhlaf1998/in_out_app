import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';

class CheckIn extends StatelessWidget {

  CheckInController checkInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: _logout()
      ),
      body: Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          child: checkInController.loading.value
              ?
          Center(
            child: CircularProgressIndicator(),
          ): Center(
            child: Stack(
              children: [
                _header(context),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                  decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.jpg"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Center(
                    child:  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: statesView(context),
                    ),
                  )
                ),
              ],
            ),
          )
      ),),
    );
  }

  _logout(){
    return GestureDetector(
      onTap: (){
        Store.logout();
      },
      child: const Icon(
          Icons.logout,
        color: Colors.white,
      ),
    );
  }


  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.27,
      decoration: const BoxDecoration(
        color: App.navyBlue,
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Global.employee!.company_image),
                )
              ),
            )
          ],
        ),
      )
    );
  }

  statesView(BuildContext context){
    if(Global.state >= 3 && (Global.myDate.day != DateTime.now().day
        || Global.myDate.month != DateTime.now().month || Global.myDate.year != DateTime.now().year) ){
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
    }else if(Global.state == 2){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          outView(context),
        ],
      );
    }else if(Global.state == 3){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          overTimeInView(context),
        ],
      );
    }else if(Global.state == 4){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          overTimeOutView(context),
        ],
      );
    }else{
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          const Text("You Cannot In More Than One Time Ber Day",
          style: TextStyle(
            color: App.navyBlue
          ),)
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
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Center(
            child: Text("In",
                style: TextStyle(color: Colors.white)),
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
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Center(
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
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Center(
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
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Center(
            child: Text("Out",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }

  overTimeInView(BuildContext context){
    return GestureDetector(
        onTap: (){
          checkInController.checkIn(4);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text("OverTime In",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }
  overTimeOutView(BuildContext context){
    return GestureDetector(
        onTap: (){
          checkInController.checkIn(5);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/3,
          height: 40,
          decoration: BoxDecoration(
              color: App.primary,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text("OverTime Out",style: TextStyle(color: Colors.white)),
          ),
        )
    );
  }
}
