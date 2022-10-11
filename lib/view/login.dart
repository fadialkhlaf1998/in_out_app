import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/login_controller.dart';
import 'package:in_out_app/helper/app.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: App.navyBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top),
            color: Colors.blue,
            child: Stack(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:const  BoxDecoration(
                        color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage("assets/new_icons/background.jpg"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),

                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50)
                      ),

                    ),
                    child: Obx(() => loginController.loading.value ?
                      App.Loading() :
                      _body(context)
                    )
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           // const SizedBox(height: 1,),
           Column(
             // mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(height: 50,),
               // Lottie.asset("assets/Intro.json",width: 170,height: 170),
               Container(
                 height: 150,
                 width: 150,
                 // color: Colors.red,
                 child: Image.asset("assets/new_icons/transparent_logo.png",fit: BoxFit.cover),
               ),
               SizedBox(height: 50,),
               Text('WELCOME TO',style: TextStyle(
                 fontSize: 28,
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
               ),),
               const SizedBox(height: 5),
               const Text("In Out Application",
                 style: TextStyle(
                     fontSize: 22,
                     color: App.primary,
                     fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 40,),
               const Text("Login to access your account",
                 style: TextStyle(
                     fontSize: 14,
                     color: Colors.white,
                     fontWeight: FontWeight.bold),),
               const SizedBox(height: 20,),
               _textField(context, loginController.username, "Username"),
               const SizedBox(height: 10),
               _passTextField(context,loginController.password,"Password"),
               const SizedBox(height: 40,),
               GestureDetector(
                 onTap: (){
                   loginController.login();
                 },
                 child: Container(
                   height: 40,
                   width: MediaQuery.of(context).size.width * 0.4,
                   decoration: BoxDecoration(
                       color: App.smallBtnBG,
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: const Center(
                     child: Text("Login",
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 18,
                             fontWeight: FontWeight.bold
                         )
                     ),
                   ),
                 ),
               ),
             ],
           ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                child: Text(
                  "© 2011 - 2021 All Rights Reserved \n Max Art Promotional Gifts Preparing LLC",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _textField(BuildContext context,TextEditingController controller,String hint){
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          label: Text(hint),
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: controller.text.isEmpty && loginController.validate.value ? 
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
          ),
          focusedBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)
          ) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
          ),
        ),
      ),
    );
  }
  _passTextField(BuildContext context,TextEditingController controller,String hint){
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: loginController.showPassword.value,
        decoration: InputDecoration(
          label: Text(hint),
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
          ),
          focusedBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              loginController.showPassword.value = !loginController.showPassword.value;
            },
            child: Icon(!loginController.showPassword.value ?
            Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 23, color: App.primary,
            ),
          )
        ),
      ),
    );
  }
}
