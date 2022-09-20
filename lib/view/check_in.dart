import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
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
      body: Obx((){
        return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: checkInController.loading.value
                        ?
                    Container(
                        color: Colors.white.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        )) : Text(''),
                  )
                ],
              ),
            )
        );
      }),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              breakInView(context),
              const SizedBox(width: 40),
              breakOutView(context),
            ],
          ),
          const SizedBox(height: 40),
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
    return Bounce(
      duration: const Duration(milliseconds: 150),
      onPressed: (){
        Store.saveDate();
        checkInController.checkIn(0);
      },
        child: Column(
          children: [
            const Text("In", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/icons/play.png')
                )
              ),
              // child: const Center(
              //   child: Text("In",
              //       style: TextStyle(color: Colors.white)),
              // ),
            ),
          ],
        )
    );
  }

  breakInView(BuildContext context){
    return Bounce(
      duration: Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(1);
        },
        child: Column(
          children: [
            const Text("Break In", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/pause.png')
                  )
              ),
            ),
          ],
        )
    );
  }

  breakOutView(BuildContext context){
    return Bounce(
      duration: Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(2);
        },
        child: Column(
          children: [
            const Text("Break Out", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/forward.png')
                  )
              ),
            ),
          ],
        )
    );
  }

  outView(BuildContext context){
    return Bounce(
      duration: Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(3);
        },
        child: Column(
          children: [
            const Text("Out", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/stop.png')
                  )
              ),
            ),
          ],
        )
    );
  }

  overTimeInView(BuildContext context){
    return Bounce(
      duration: const Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(4);
        },
        child: Column(
          children: [
            const Text("Over time In", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/upload.png')
                  )
              ),
            ),
          ],
        )
    );
  }
  overTimeOutView(BuildContext context){
    return Bounce(
      duration: const Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(5);
        },
        child: Column(
          children: [
            const Text("Over time Out", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/download.png')
                  )
              ),
            ),
          ],
        )
    );
  }
}
