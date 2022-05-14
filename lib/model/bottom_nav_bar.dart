import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ventpost/controller/home_page_controller.dart';
final  hmcontroller = Get.put(Controllerhm());


class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  DotNavigationBar(
      enableFloatingNavBar: true,
      margin: const EdgeInsets.all(0),
      paddingR: const EdgeInsets.all(0),
      currentIndex: hmcontroller.count.value, 
      onTap:(index) => hmcontroller.increment(index) ,
      dotIndicatorColor: Colors.black,
      items: [

         /// Home
        DotNavigationBarItem(
          icon: const Icon(Icons.home),
          selectedColor: Colors.purple,
        ),

        /// Likes
        DotNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          selectedColor: Colors.pink,
        ),

        
        /// Profile
        DotNavigationBarItem(
          icon: const Icon(Icons.person),
          selectedColor: Colors.teal,
        ),
        
      ],
    ),);
  }
}