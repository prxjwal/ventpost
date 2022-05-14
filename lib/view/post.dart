import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/controller/post_controller.dart';
import 'package:ventpost/view/home_page.dart';

final firebase_controller = Get.find<FirebaseControl>();

final post_controller = Get.put(Pcontroller());

class Postdata extends StatelessWidget {
  const Postdata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ClayContainer(
              depth: 30,
              height: 50,
              borderRadius: 200,
              width: Get.width - 40,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Get.to(() => const HomePage());
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Compose Letter",
                    style: GoogleFonts.ubuntu(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width - 30,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.12),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                "Title",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            width: Get.width - 25,
                            height: 75,
                            child: TextField(
                              onChanged: (val) {
                                post_controller.title = val;
                              },
                              decoration: const InputDecoration(),
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                              ),
                              maxLines: 6,
                              maxLength: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.12),
                    ),
                    width: Get.width - 30,
                    height: Get.height / 3 - 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width - 30,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.12),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                "Postcard lines",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            width: Get.width - 25,
                            height: 120,
                            child: TextField(
                              onChanged: (val) {
                                post_controller.postcardLines = val;
                              },
                              decoration: const InputDecoration(),
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                              ),
                              maxLines: 6,
                              maxLength: 80,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.12),
                    ),
                    width: Get.width - 30,
                    height: Get.height / 3 - 60,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width - 30,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.12),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              Text(
                                "Letter",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            width: Get.width - 25,
                            height: 210,
                            child: TextField(
                              onChanged: (val) {
                                post_controller.letter = val;
                              },
                              decoration: const InputDecoration(),
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 18,
                              ),
                              maxLines: 6,
                              maxLength: 300,
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.12),
                    ),
                    width: Get.width - 30,
                    height: Get.height / 3,
                  ),
                ],
              ),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, right: 40, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    if (post_controller.title == '') {
                      Get.snackbar('⚠️', 'please fill the title');
                    } else if (post_controller.postcardLines == '') {
                      Get.snackbar('⚠️', 'please fill the postcard');
                    } else if (post_controller.letter == '') {
                      Get.snackbar('⚠️', 'please fill the letter body');
                    } else {
                      firebase_controller.post_to_main();
                      Get.snackbar('✔️', 'posted sucessfully!');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClayContainer(
                      width: 150,
                      height: 60,
                      borderRadius: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send',
                            style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.send_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
