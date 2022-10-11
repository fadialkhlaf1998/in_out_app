import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/profile_controller.dart';
import 'package:in_out_app/helper/api.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';
import 'package:in_out_app/helper/store.dart';
import 'package:in_out_app/view/change_password.dart';
import 'package:in_out_app/view/work_hours.dart';

class Profile extends StatelessWidget {

  ProfileController profileController = Get.put(ProfileController());

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
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        SizedBox(
                            width: Get.width,
                            height: 60,
                            child: Center(
                              child: Container(
                                width: Get.width * 0.95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: (){
                                          Get.back();
                                        },
                                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      height: 60,
                                      child: Center(
                                        child: SvgPicture.network( Global.employee!.company_image),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios,color: Colors.transparent,),
                                  ],
                                ),
                              ),
                            )
                        ),
                        const SizedBox(height: 100),
                        SizedBox(
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
                                    image: NetworkImage(Api.url + 'uploads/' +Global.employee!.image),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: App.primary),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      profileController.editImage.value = true;
                                      profileController.imageList.clear();
                                      profileController.existingPicture.value = false;
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: App.primary,
                                          shape: BoxShape.circle
                                      ),
                                      // padding: EdgeInsets.all(2),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(Icons.edit,color: App.navyBlue),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        _body()
                      ],
                    ),
                  ),
                 GestureDetector(
                   onTap: (){
                     profileController.editImage.value = false;
                     profileController.imageList.clear();
                   },
                   child: AnimatedContainer(
                     duration: const Duration(milliseconds: 1000),
                     curve: Curves.fastOutSlowIn,
                     width: Get.width,
                     height: profileController.editImage.value ? Get.height : 0,
                     color: profileController.editImage.value ? Colors.black.withOpacity(0.5) : Colors.transparent,
                   ),
                 ),
                  Positioned(
                    top: 100,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      child: profileController.imageList.isNotEmpty ?
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(profileController.imageList.first)
                            )
                        ),
                      ): Text(''),
                    ),
                  ),
                  AnimatedPositioned(
                      right:  profileController.editImage.value ? Get.width * 0.25 : -100,
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: (){
                          profileController.selectPhotoFromCamera();
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: App.primary,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.camera, color: Colors.white,size: 30,),
                                SizedBox(height: 5,),
                                Text('Camera',style: TextStyle(color: Colors.white),)
                              ],
                            )
                          ),
                        ),
                      )
                  ),
                  AnimatedPositioned(
                      left:  profileController.editImage.value ? Get.width * 0.25 : -100,
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: (){
                          profileController.selectPhotoFromGallery();
                        //  profileController.editImage.value = false;
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: App.primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.image, color: Colors.white,size: 30,),
                                SizedBox(height: 5,),
                                Text('Gallery',style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                  profileController.existingPicture.value
                      ? AnimatedPositioned(
                      bottom:  profileController.editImage.value ? Get.height * 0.3 : -100,
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: (){
                          profileController.uploadImage();
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: App.primary,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: profileController.loading.value
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:  CircularProgressIndicator(color: Colors.white,strokeWidth: 3),
                            )
                                : const Text('Upload',style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      )
                  )
                      : const Text(''),
                ],
              )
          ),
        ),
      );
    });
  }

  _body(){
    return Container(
      width: Get.width,
      child: Column(
        children: [
          CustomProfileButton(
            onTap: (){
              Get.to(()=>ChangePassword());
            },
              width: 0.9,
              height: 40,
              color: Colors.transparent,
            title: 'Change password',
            icon: Icons.key,
          ),
          CustomProfileButton(
              onTap: (){
                Get.to(()=>WorkHours());
              },
              width: 0.9,
              height: 40,
              color: Colors.transparent,
              title: 'My work hours',
            icon: Icons.access_time_outlined,
          ),
          CustomProfileButton(
              onTap: (){
                Store.logout();
              },
              width: 0.9,
              height: 40,
              color: Colors.transparent,
              title: 'Log out',
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}

class CustomProfileButton extends StatelessWidget {

  double width;
  double height;
  Color color;
  String title;
  VoidCallback onTap;
  IconData icon;


  CustomProfileButton({
    required this.width,
    required this.height,
    required this.color,
    required this.title,
    required this.onTap,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: Get.width * width,
            height: height,
            color: color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.white, size: 20,),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                const Icon(
                    Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white.withOpacity(0.5),thickness: 1,indent: Get.width * 0.05,endIndent: Get.width * 0.05,)
      ],
    );
  }
}

