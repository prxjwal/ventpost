import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  late TextEditingController usernamecontroller;
  var username = '';

  @override
  void onInit() {
    super.onInit();
    usernamecontroller = TextEditingController();
    
    
  }


  @override
  void onClose() {
    usernamecontroller.dispose();
   
  }



  String? validateUsername(String value) {
    if (value.length < 6) {
      return "only six letter are allowed";
    }
    return null;
  }
}