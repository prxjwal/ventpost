import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/controller/trending_controller.dart';
import 'package:ventpost/model/bottom_nav_bar.dart';
import 'package:ventpost/view/cards.dart';
import 'dart:math' as math;

import 'package:ventpost/view/post.dart';

final FirebaseController = Get.put(FirebaseControl());

final controller = Get.put(Trending_dart());

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const Bottomnavbar(),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: ClayContainer(
                borderRadius: 10,
                child: Container(
                  width: Get.width - 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Trending",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      ClayContainer(
                        borderRadius: 10,
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                            child: Obx(
                              () => DropdownButton(
                                underline: Container(
                                  height: 0,
                                ),
                                value: controller.Value_t.value,
                                style: GoogleFonts.ubuntu(
                                    fontSize: 18, color: Colors.black),
                                onChanged: (String? newValue) {
                                  controller.Value_t.value = newValue!;

                                  if (newValue == "all-time") {
                                    controller.a.value =
                                        FirebaseController.final_trend_a;
                                  }
                                  if (newValue == "month") {
                                    controller.a.value =
                                        FirebaseController.final_trend_m;
                                  }
                                  if (newValue == "year") {
                                    controller.a.value =
                                        FirebaseController.final_trend_year;
                                  }
                                },
                                items: <String>[
                                  'year',
                                  'month'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: 600,
                width: Get.width,
                child: Obx(
                  () => Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.a.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Cards(
                            postid: controller.a[index][0],
                            username: controller.a[index][1],
                            age: controller.a[index][2],
                            flagcode: controller.a[index][3],
                            bodytitle: controller.a[index][4],
                            cardtext: controller.a[index][5],
                            bodytext: controller.a[index][6],
                          );
                        }),
                  ),
                )),
          ],
        ))));
  }
}
