import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/change_password_controller.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:in_out_app/helper/global.dart';

class ChangePassword extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());


  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Container(
              width: Get.width,
              height: Get.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _header(context),
                  _body(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context){
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
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
                    child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: 60,
                  child: Center(
                    child: SvgPicture.network(Global.employee!.company_image),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,color: Colors.transparent,),
              ],
            ),
          ),
        )
    );
  }
  
  _body(context){
    return Container(
      // height: Get.height * 0.7,
      child: Center(
        child: Column(
          children: [
            CustomProfileTextField(
                width: 0.9,
                height: 50,
              controller: changePasswordController.oldPassword,
              hint: 'Old Password',
              showPassword: changePasswordController.showPassword1,
            ),
            const SizedBox(height: 15),
            CustomProfileTextField(
              width: 0.9,
              height: 50,
              controller: changePasswordController.newPassword,
              hint: 'New Password',
              showPassword: changePasswordController.showPassword2,
            ),
            const SizedBox(height: 15),
            CustomProfileTextField(
              width: 0.9,
              height: 50,
              controller: changePasswordController.confirmPassword,
              hint: 'Confirm new Password',
              showPassword: changePasswordController.showPassword2,

            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                changePasswordController.saveNewPassword();
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: App.smallBtnBG,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class CustomProfileTextField extends StatelessWidget {

  ChangePasswordController changePasswordController = Get.find();


  double width;
  double height;
  TextEditingController controller;
  String hint;
  RxBool showPassword;


  CustomProfileTextField({
    required this.width,
    required this.height,
    required this.controller,
    required this.hint,
    required this.showPassword
  });

  @override
  Widget build(BuildContext context) {
    return  Obx((){
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          obscureText: showPassword.value,
          decoration: InputDecoration(
              label: Text(hint),
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: controller.text.isEmpty && changePasswordController.validate.value ?
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red)) :
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)
              ),
              focusedBorder: controller.text.isEmpty && changePasswordController.validate.value ?
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red)) :
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)
              ),
              suffixIcon: GestureDetector(
                onTap: (){
                  showPassword.value = !showPassword.value;
                },
                child: Icon(!showPassword.value ?
                Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 23, color: App.primary,
                ),
              )
          ),
        ),
      );
    });
  }
}

