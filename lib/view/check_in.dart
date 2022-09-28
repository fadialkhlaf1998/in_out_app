import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckIn extends StatelessWidget {

  CheckInController checkInController = Get.find();
  CheckIn(){
    checkInController.alwaysUpdateScreen();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: App.smallBtnBG,
      body: Obx((){
        return SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Stack(
                  children: [
                    checkInController.fake.value?Center():Center(),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/new_icons/background.jpg")
                        )
                      ),
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/new_icons/background.jpg"),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width*0.9,
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  _logout(Colors.transparent),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    height: 120,
                                    child: Center(
                                        child: SvgPicture.network(Global.employee!.company_image),
                                    ),
                                  ),
                                  _logout(Colors.white),

                                ],
                              ),
                            ),
                            Container(
                              width: Get.width,
                              height: Get.height-120-MediaQuery.of(context).padding.top-Get.bottomBarHeight,
                              child: statesView(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    checkInController.bottomSheetOpened.value?Center():Positioned(child:  bottomSheetBtn(context),bottom: 0,),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: checkInController.loading.value
                          ?
                      Container(
                         // color: Colors.white.withOpacity(0.3),
                        decoration: BoxDecoration(
                          color: App.navyBlue,
                          image: DecorationImage(
                            image: AssetImage('assets/images/background.png')
                          )
                        ),
                          child: App.Loading()) : Text(''),
                    )
                  ],
                ),
              )
          ),
        );
      }),
    );
  }
  bottomSheetBtn(BuildContext context){
    return GestureDetector(
      onTap: (){
        bottomSheet(context);
      },
      onVerticalDragStart: (position){
        bottomSheet(context);
      },
      child: Container(
        height: 50,
        width: Get.width,
        // color: Colors.red,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/new_icons/chevron-circle-up-Bold.svg",width: 25,)
              ],
            ),
            Positioned(child: Container(
              height: 40,
              width: Get.width,

              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
            ),bottom: 0,)
          ],
        )
      ),
    );
  }
  late PersistentBottomSheetController _controller;
  bottomSheet(BuildContext context){
    checkInController.bottomSheetOpened.value = true;
    checkInController.getApplist();
    showMaterialModalBottomSheet(
      context: context,
        backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: Get.height*0.6+40,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height*0.6+30,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                ),
                child: SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                  child: Obx(() {
                    return Container(
                      // color: Colors.white.withOpacity(0.5),
                      width: MediaQuery.of(context).size.width,
                      height: Get.height*0.6,
                      child: checkInController.bottomSheetLoading.value?
                      App.Loading()
                          :checkInController.persons.length == 0?
                      Center(child: Text("No One Yet",style: TextStyle(color: Colors.white),),)
                      :ListView.builder(
                        itemCount: checkInController.persons.length,
                        itemBuilder: (context,index){
                          return Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(checkInController.persons[index].image),
                                                fit: BoxFit.fill
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white)
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(checkInController.persons[index].employee,style: TextStyle(color: Colors.white,fontSize: 16),),
                                              Text(checkInController.persons[index].getDescription(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(checkInController.persons[index].getState(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
                                          Text(checkInController.persons[index].getClock(),style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 16),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: Get.width*0.9,
                                  child:  Divider(color: Colors.white,height: 1.5),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  })
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_drop_down_circle_outlined,color: Colors.white,)
              ],
            ),
          ],
        ),
      ),
    ).then((value) {
      checkInController.bottomSheetOpened.value = false;
    });
  }

  _logout(Color color){

    return GestureDetector(
      onTap: (){
        Store.logout();
      },
      child: Icon(
          Icons.logout,
        color: color,
      ),
    );
  }

  statesView(BuildContext context){
    if(checkInController.bottomSheetOpened.value){
      return Center();
    }
    if(Global.state >= 3 && (Global.myDate.day != DateTime.now().day
        || Global.myDate.month != DateTime.now().month || Global.myDate.year != DateTime.now().year) ){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtn("assets/new_icons/check_in.svg","Check-In",Colors.white,0),
        ],
      );
    }else if(Global.state == 0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bigBtn("assets/new_icons/check_in.svg","Check-In",Colors.green,0),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10,),
              SizedBox(width: 10,),
              smallBtn("assets/new_icons/break_in.svg","Break-In",Colors.white,1),
              smallBtn("assets/new_icons/check_out.svg","Check-Out",Colors.white,3),
              SizedBox(width: 10,),
              SizedBox(width: 10,),
            ],
          )

        ],
      );
    }else if(Global.state == 1){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bigBtnPercentBar("assets/new_icons/break_in.svg","Break-In",Colors.green,0,Duration(milliseconds: 1800)),
          SizedBox(height: 20,),
          smallBtn("assets/new_icons/break_out.svg","Break-Out",Colors.white,2),
        ],
      );
    }else if(Global.state == 2){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtn("assets/new_icons/check_out.svg","Check-Out",Colors.white,3),
        ],
      );
    }else if(Global.state == 3){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtnOverTimeIn("assets/new_icons/over_in.svg","Extra Overtime - IN",Colors.white,4),
        ],
      );
    }else if(Global.state == 4){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          Column(
            children: [
              bigBtnOverTimeIn("assets/new_icons/over_in.svg","Extra Overtime - IN",Colors.green,4),
              SizedBox(height: 20,),
              smallBtnOver("assets/new_icons/over_out.svg", "Extra Overtime - Out", Colors.white, 5)
            ],
          )
          
        ],
      );
    }else if (Global.state == 5){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtnOverTimeOut("assets/new_icons/over_out.svg","Extra Overtime - Out",Colors.red,4),
        ],
      );
    }
  }

  inView(BuildContext context){
    return bigBtn("assets/new_icons/check_in.svg","Check-In",Colors.white,0);
  }
  bigBtn(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.checkIn(state);
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(width: 2,color: color),
            ),
            child: Center(
              child: SvgPicture.asset(image,width: 75,color: color,),
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 18)),
        ],
      ),
    );

  }
  bigBtnOverTimeIn(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.checkIn(state);
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(width: 2,color: color),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 44,
                  left: 29,
                  child: SvgPicture.asset(image,width: 75,color: color,),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 18)),
        ],
      ),
    );

  }
  bigBtnOverTimeOut(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.checkIn(state);
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(width: 2,color: color),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 44,
                  right: 29,
                  child: SvgPicture.asset(image,width: 75,color: color,),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 18)),
        ],
      ),
    );

  }
  bigBtnPercentBar(String image,String title,Color color,int state,Duration duration){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.checkIn(state);
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
              // border: Border.all(width: 2,color: color),
            ),
            child: Obx(() {
                return Column(
                children: [
                  checkInController.fake.value?Center():Center(),
                  CircularPercentIndicator(
                    radius: 75.0,
                    lineWidth: 2.0,
                    percent:
                    Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/30>1
                        ?1
                        :Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/30,
                    center: Center(
                      child: SvgPicture.asset(image,width: 75,color: color,),
                    ),
                    progressColor: getPecentageColor(Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/30),

                    // widgetIndicator:
                  )
                ],
              );
            }
                )
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 18)),
        ],
      ),
    );

  }
  smallBtn(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        checkInController.checkIn(state);
      },
      duration: Duration(milliseconds: 150),
      child: Container(
        width: 120,
        height: 35,
        decoration: BoxDecoration(
          color:  App.smallBtnBG,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(image,width: 25,color: color,),
            // SizedBox(width: 10,),
            Text(title, style: TextStyle(color: color,fontSize: 14)),
          ],
        ),
      ),
    );
  }
  smallBtnOver(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        checkInController.checkIn(state);
      },
      duration: Duration(milliseconds: 150),
      child: Container(
        width: 175,
        height: 35,
        decoration: BoxDecoration(
            color:  App.smallBtnBG,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(image,width: 25,color: color,),
            // SizedBox(width: 10,),
            Text(title, style: TextStyle(color: color,fontSize: 14)),
          ],
        ),
      ),
    );
  }
  getPecentageColor(double value){
    if(value < 0.35){
      return Colors.green;
    }else if(value < 0.7){
      return Colors.orange;
    }else{
      return Colors.red;
    }
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
                      image: AssetImage('assets/icons/break.png')
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
                      image: AssetImage('assets/icons/break-out.png')
                  )
              ),
            ),
          ],
        )
    );
  }

  outView(BuildContext context){
    return Bounce(
      duration: const Duration(milliseconds: 150),
        onPressed: (){
          checkInController.checkIn(3);
        },
        child: Column(
          children: [
            const Text("Out", style: TextStyle(color: App.navyBlue,fontSize: 16)),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('assets/icons/logout.png')
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
                      image: AssetImage('assets/icons/time-in.png')
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
                      image: AssetImage('assets/icons/time.png')
                  )
              ),
            ),
          ],
        )
    );
  }
}
