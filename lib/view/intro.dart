import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/intro_controller.dart';

class Intro extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/in_out.jpg"),
                fit: BoxFit.cover
              )
            ),
            // child: Center(
            //   child: CircularProgressIndicator(),
            // )
        ),
      ),
    );
  }
}
