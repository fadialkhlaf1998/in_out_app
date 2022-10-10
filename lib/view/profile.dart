import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/new_icons/background.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
            child:Container(
              width: Get.width,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                      width: Get.width,
                      height: 60,
                      child: Center(
                        child: Container(
                          width: Get.width*0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                height: 60,
                                child: Center(
                                  child: SvgPicture.network(Global.employee!.company_image),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios,color: Colors.transparent,),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 100,
                    height: 110,
                    // color: App.primary,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(Global.employee!.image),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: App.primary),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: App.primary,
                              shape: BoxShape.circle
                            ),
                            // padding: EdgeInsets.all(2),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.edit,color: App.navyBlue),
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
