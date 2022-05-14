import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ventpost/view/home_page.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _navigate_home();
    super.initState();
  }

  _navigate_home() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      Get.to(const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
