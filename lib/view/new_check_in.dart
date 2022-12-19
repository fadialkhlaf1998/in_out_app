import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/check_in_controller.dart';
import 'package:in_out_app/controller/new_check_in_controller.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/view/profile.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckIn extends StatelessWidget {

  CheckInController checkInController = Get.find();



  CheckIn(){
    checkInController.initial = true;
  }
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(

      extendBodyBehindAppBar: true,
      backgroundColor: App.navyBlue,
      body: Obx((){
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/new_icons/background.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Stack(
                        children: [
                          checkInController.fake.value?Center():Center(),
                          GestureDetector(
                            onTap: (){
                              focusNode.unfocus();
                            },
                            child: Container(

                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          width: Get.width,
                                          height: 60,
                                          child: Center(
                                            child: Container(
                                              width: Get.width*0.95,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Row(

                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        color: Colors.transparent,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Icon(Icons.arrow_forward_ios,color: Colors.transparent,)
                                                    ],
                                                  ),

                                                  GestureDetector(
                                                    onTap: (){
                                                      Get.to(()=>Profile());
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: NetworkImage(Api.url + 'uploads/' + Global.employee!.image)
                                                              ),
                                                              shape: BoxShape.circle,
                                                              border: Border.all(color: App.primary)
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            width: MediaQuery.of(context).size.width*0.7,
                                            height: 100,
                                            child: Center(
                                              child: SvgPicture.network(Global.employee!.company_image),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 30,),
                                      statesView(context),
                                      SizedBox(height: 30,),
                                      Container(
                                        width: Get.width * 0.7,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: App.navyBlue,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: TextField(
                                          focusNode: focusNode,
                                          controller: checkInController.note,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(color: Colors.white,fontSize: 13),
                                          maxLines: 100,
                                          decoration: InputDecoration(
                                            label:Container(
                                              width: 105,
                                              child:  Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Note ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                                  Text("(optional)",style: TextStyle(color: Colors.white,fontSize: 12),)
                                                ],
                                              ),
                                            ),
                                            alignLabelWithHint: true,
                                            enabled: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(color: Colors.transparent)
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: Colors.transparent)
                                            ),
                                            // focusedBorder:  OutlineInputBorder(
                                            //     borderRadius: BorderRadius.circular(10),
                                            //     borderSide: BorderSide(color: Colors.white)
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: checkInController.loading.value||checkInController.afterLoading.value
                                ?
                            Container(
                              // color: Colors.white.withOpacity(0.3),
                                decoration: BoxDecoration(
                                    color: App.navyBlue,
                                    image: DecorationImage(
                                        image: AssetImage('assets/new_icons/background.jpg'),
                                        fit: BoxFit.cover
                                    )
                                ),
                                child: checkInController.afterLoading.value?App.tick():App.Loading()) : Text(''),
                          )
                        ],
                      ),
                    )
                ),
              ),

            ],
          ),
        );
      }),
    );
  }

  statesView(BuildContext context){
    if(checkInController.bottomSheetOpened.value){
      return Center();
    }
    if(Global.state == 0){
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtn("assets/new_icons/check_in.svg","Check-In",Colors.green),
        ],
      );
    }else{
      return Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 10,
        spacing: 10,
        children: [
          bigBtn("assets/new_icons/check_in.svg","Check-Out",Colors.red),
        ],
      );
    }
  }

  inView(BuildContext context){
    return bigBtn("assets/new_icons/check_in.svg","Start Work",Colors.white);
  }
  bigBtn(String image,String title,Color color){
    return Bounce(
      onPressed: (){
        checkInController.newCheckIn();
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            height: 150,width: 150,
            child: Stack(
              children: [
                Center(

                    child: Obx(() => AnimatedContainer(
                      duration:Duration(milliseconds: 1000),
                      // margin: EdgeInsets.only(top: 10),
                      width: checkInController.fake.value ?150:130,
                      height: checkInController.fake.value ?150:130,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(width: 2,color: color),
                      ),
                      child: Center(
                        child: SvgPicture.asset(image,width: 75,color: color,),
                      ),
                    ),)
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 20)),
        ],
      ),
    );

  }
  bigBtnOverTimeIn(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.overTime();
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,

            child: Stack(
              children: [

                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    // margin: EdgeInsets.only(top: 10),
                    width: checkInController.fake.value ?150:130,
                    height: checkInController.fake.value ?150:130,
                    decoration: BoxDecoration(
                      color: checkInController.fake.value ?color.withOpacity(0.3):color.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,color: color),
                    ),),
                ),
                Positioned(
                  top: 44,
                  left: 29,
                  child: SvgPicture.asset(image,width: 75,color: color,),),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 20)),
        ],
      ),
    );

  }
  bigBtnOverTimeOut(String image,String title,Color color,int state){
    return Bounce(
      onPressed: (){
        if(color == Colors.white){
          checkInController.overTime();
        }
      },
      duration: Duration(milliseconds: 150),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,

            child: Stack(
              children: [

                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    // margin: EdgeInsets.only(top: 10),
                    width: checkInController.fake.value ?150:130,
                    height: checkInController.fake.value ?150:130,
                    decoration: BoxDecoration(
                      color: checkInController.fake.value ?color.withOpacity(0.3):color.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(width: 2,color: color),
                    ),),
                ),
                Positioned(
                  top: 44,
                  right: 29,
                  child: SvgPicture.asset(image,width: 75,color: color,),),

              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 20)),
        ],
      ),
    );

  }
  bigBtnOverTimeOutArchive(String image,String title,Color color,int state){
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
          Text(title, style: TextStyle(color: color,fontSize: 20)),
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
                      Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/60>1
                          ?1
                          :Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/60,
                      center: Center(
                        child: SvgPicture.asset(image,width: 75,color: color,),
                      ),
                      progressColor: getPecentageColor(Global.employee!.getLastDateOp()!.difference(DateTime.now()).inMinutes.abs()/60),

                      // widgetIndicator:
                    )
                  ],
                );
              }
              )
          ),
          SizedBox(height: 20,),
          Text(title, style: TextStyle(color: color,fontSize: 20)),
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
