import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/login_controller.dart';

class Login extends StatelessWidget {

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Obx(() => loginController.loading.value
          ?Center(
            child: CircularProgressIndicator(),
          )
          :Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("In Out Application",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Please Enter Your Username and Password"),
                    SizedBox(height: 40,),
                    _textField(context, loginController.username, "Username"),
                    SizedBox(height: 20,),
                    _passTextField(context,loginController.password,"Password"),
                    SizedBox(height: 40,),
                    Text("Copy Right Maxart",style: TextStyle(color: Colors.grey,fontSize: 10),),
                    SizedBox(height: 40,),
                    GestureDetector(
                      onTap: (){
                        loginController.login();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Login",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          )
        ),
      ),
    );
  }
  _textField(BuildContext context,TextEditingController controller,String hint){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(hint),
          enabledBorder: controller.text.isEmpty&&loginController.validate.value
              ?OutlineInputBorder(
               borderSide: BorderSide(color: Colors.red)
              )
              :OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder:  controller.text.isEmpty&&loginController.validate.value
              ?OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          )
              :OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)
          ),
        ),
      ),
    );
  }

  _passTextField(BuildContext context,TextEditingController controller,String hint){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        obscureText: loginController.showPassword.value,
        decoration: InputDecoration(
          label: Text(hint),
          enabledBorder: controller.text.isEmpty&&loginController.validate.value
              ?OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          )
              :OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder:  controller.text.isEmpty&&loginController.validate.value
              ?OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
          )
              :OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              loginController.showPassword.value = !loginController.showPassword.value;
            },
            child: Icon(!loginController.showPassword.value?Icons.visibility_outlined:Icons.visibility_off_outlined),
          )
        ),
      ),
    );
  }
}
