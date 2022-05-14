// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';
import 'package:ventpost/view/page.dart';

class Cards extends StatelessWidget {
  const Cards({
    Key? key,
    @required this.postid,
    @required this.username,
    @required this.flagcode,
    @required this.age,
    @required this.cardtext,
    @required this.bodytext,
    @required this.bodytitle,
  }) : super(key: key);
  final postid;
  final age;

  final username;
  final flagcode;
  final cardtext;
  final bodytitle;
  final bodytext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const Page_show(),
            arguments: [bodytitle, bodytext, postid]);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xffF3CEA1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Text(
                  'Vent mail',
                  style: GoogleFonts.monsieurLaDoulaise(
                      color: Colors.black, fontSize: 35),
                ),
                SizedBox(
                  width: 160,
                  height: 50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          right: 2,
                          top: 3,
                          child: Image.asset(
                            'lib/assets/stamp.png',
                            width: 100,
                            height: 60,
                          )),
                      Positioned(
                        right: 18,
                        top: 15,
                        child: CircleAvatar(
                            radius: 18,
                            child: ClipOval(
                                child: Flag.fromString(
                              flagcode.replaceAll("'", ""),
                              height: 80,
                              width: 130,
                              fit: BoxFit.cover,
                            ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Container(
                        // color: Colors.white,
                        margin: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              username,
                              style: GoogleFonts.homemadeApple(
                                  color: Colors.black,
                                  fontSize: 15,
                                  textStyle:
                                      const TextStyle(letterSpacing: 0.5)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15, left: 20),
                              child: Text(
                                cardtext,
                                style: GoogleFonts.reenieBeanie(
                                  color: Colors.black,
                                  fontSize: 20,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 120,
                  width: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 80,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
