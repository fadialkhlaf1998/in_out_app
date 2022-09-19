import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/login_controller.dart';
import 'package:in_out_app/helper/app.dart';

class Login extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        color: App.navyBlue,
                          image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 70),
                        SvgPicture.asset("assets/icons/maxart-logo.svg",
                            color: App.primary,width: 70,height: 70),
                      ],
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50)
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Obx(() => loginController.loading.value ?
                      const Center(child: CircularProgressIndicator()) :
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
           const SizedBox(height: 20,),
           Column(
             children: [
               AnimatedTextKit(
                 animatedTexts: [
                   WavyAnimatedText(
                     'WELCOME TO',
                     textStyle: const TextStyle(
                       fontSize: 24,
                       color: App.navyBlue,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ],
               ),
               const SizedBox(height: 5),
               const Text("In Out Application",
                 style: TextStyle(
                     fontSize: 18,
                     color: App.primary,
                     fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 15,),
               const Text("Login to access your account",
                 style: TextStyle(
                     fontSize: 14,
                     color: App.navyBlue,
                     fontWeight: FontWeight.bold),),
               const SizedBox(height: 40,),
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
                       color: App.navyBlue,
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
                  style: TextStyle(color: App.navyBlue,fontSize: 10),
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
        style: const TextStyle(color: App.navyBlue),
        decoration: InputDecoration(
          label: Text(hint),
          labelStyle: const TextStyle(color: App.navyBlue),
          enabledBorder: controller.text.isEmpty && loginController.validate.value ? 
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: App.navyBlue)
          ),
          focusedBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)
          ) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: App.navyBlue)
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
        style: const TextStyle(color: App.navyBlue),
        obscureText: loginController.showPassword.value,
        decoration: InputDecoration(
          label: Text(hint),
          labelStyle: const TextStyle(color: App.navyBlue),
          enabledBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: App.navyBlue)
          ),
          focusedBorder: controller.text.isEmpty && loginController.validate.value ?
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)) :
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: App.navyBlue)
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
