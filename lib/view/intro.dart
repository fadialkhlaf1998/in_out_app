import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_out_app/controller/intro_controller.dart';

class Intro extends StatelessWidget {

  IntroController introController = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(),
            )
        ),
      ),
    );
  }
}
