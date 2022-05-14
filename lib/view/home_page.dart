import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/controller/home_page_controller.dart';
import 'package:ventpost/model/bottom_nav_bar.dart';
import 'package:ventpost/view/menu.dart';
import 'package:ventpost/view/post.dart';
import 'cards.dart';
import 'dart:math' as math;

var flag = 0;
final hmcontroller = Get.put(Controllerhm());
final FirebaseController = Get.put(FirebaseControl());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    spin();
    FirebaseController.getdata();
    sleep(const Duration(seconds: 1));
    FirebaseController.gettrend_y();
    FirebaseController.gettrend_m();
    FirebaseController.gettrend_all();
  }

  int counter = 0;
  spin() async {
    await Future.delayed(const Duration(milliseconds: 6000), () {
      setState(() {
        flag = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const Bottomnavbar(),
        body: Stack(
          children: [
            Column(
              children: [
                const Menu(),
                Expanded(
                  child: Stack(
                    children: [
                      StreamBuilder(
                          stream: FirebaseController.streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            return ListView.builder(
                                itemCount:
                                    FirebaseController.incoming_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Cards(
                                    postid: FirebaseController
                                        .incoming_list[index][0],
                                    username: FirebaseController
                                        .incoming_list[index][1],
                                    age: FirebaseController.incoming_list[index]
                                        [2],
                                    flagcode: FirebaseController
                                        .incoming_list[index][3],
                                    bodytitle: FirebaseController
                                        .incoming_list[index][4],
                                    cardtext: FirebaseController
                                        .incoming_list[index][5],
                                    bodytext: FirebaseController
                                        .incoming_list[index][6],
                                  );
                                });
                          }),
                      Positioned(
                        right: 20.0,
                        bottom: 0,
                        child: Transform.rotate(
                          angle: -math.pi / 6,
                          child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.send_rounded,
                                size: 25,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                FirebaseController.getdata();
                                Get.to(() => const Postdata());
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            flag == 0
                ? Opacity(
                    opacity: 0.7,
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox.shrink(),
            flag == 0
                ? SpinKitChasingDots(
                    size: 60,
                    itemBuilder: (context, index) {
                      return const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.red));
                    },
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
