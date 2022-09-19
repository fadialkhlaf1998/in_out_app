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
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: App.navyBlue,
                      image: DecorationImage(
                          image: AssetImage("assets/images/background.jpg"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 70),
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
        )
        // child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     decoration: const BoxDecoration(
        //       image: DecorationImage(
        //         image: AssetImage("assets/images/background.jpg"),
        //         fit: BoxFit.cover
        //       )
        //     ),
        //     child: Obx(() => loginController.loading.value ?
        //     const Center(child: CircularProgressIndicator()) :
        //     _body(context)
        //   )
        // ),
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: App.navyBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)
        ),
      ),
      child: const Center(
        child: Text("Log In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
    );
  }
  _body(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
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
              const SizedBox(height: 10),
              const Text("In Out Application",
                style: TextStyle(
                    fontSize: 18,
                    color: App.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              const Text("Login to access your account",
                style: TextStyle(
                    fontSize: 14,
                    color: App.navyBlue,
                    fontWeight: FontWeight.bold),),
              const SizedBox(height: 40,),
              _textField(context, loginController.username, "Username"),
              const SizedBox(height: 20,),
              _passTextField(context,loginController.password,"Password"),
              const SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  loginController.login();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                      color: App.navyBlue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text("Copy Right Maxart",style: TextStyle(color: App.navyBlue,fontSize: 10),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _textField(BuildContext context,TextEditingController controller,String hint){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
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
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
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
