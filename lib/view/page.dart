import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/controller/home_page_controller.dart';
import 'package:ventpost/controller/page_controller.dart';

final controllerp = Get.put(Pagecontroller());
final firebase_controller = Get.find<FirebaseControl>();
final hmcontroller = Get.put(Controllerhm());

num report_entry = 0;
RxInt colourc = 0.obs;
var likedata;
var userlist;
RxInt flag = 0.obs;
var idl;
var fbl;

class Page_show extends StatefulWidget {
  const Page_show({Key? key}) : super(key: key);

  @override
  _Page_showState createState() => _Page_showState();
}

class _Page_showState extends State<Page_show> {
  @override
  void initState() {
    idl = Get.arguments[2];
    fbl = firebase_controller.like_list;
    print(idl);
    if (firebase_controller.like_list.contains(Get.arguments[2])) {
      flag.value = 1;
    } else {
      flag.value = 0;
    }
  }

  @override
  void dispose() {
    if (flag.value == 0) {
      if (fbl.contains(idl)) {
        firebase_controller.like_list.remove(idl);
      }
    }

    // hmcontroller.likelist[userlist] = flag.join('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xfff6dad4),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffF3CEA1),
                    margin:
                        const EdgeInsets.only(top: 100, right: 20, left: 20),
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Container(
                              margin: const EdgeInsets.only(top: 30, left: 10),
                              child: Text(
                                Get.arguments[0],
                                style: GoogleFonts.pacifico(
                                    textStyle: const TextStyle(fontSize: 25)),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 50, left: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(
                            Get.arguments[1].toString(),
                            style: GoogleFonts.pacifico(
                                textStyle: const TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Vote_report()
          ],
        ),
      ),
    );
  }
}

class Vote_report extends StatelessWidget {
  const Vote_report({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            onTap: () {
              // firebase_controller.post_like(postid: idl);
              // if (firebase_controller.like_list.contains(Get.arguments[2])) {
              // } else {
              //   firebase_controller.like_list.add(Get.arguments[2]);
              //   //   firebase_controller.post_like(postid: Get.arguments[2]);
              // }
              // print(firebase_controller.like_list);

              flag.value == 0 ? flag.value = 1 : flag.value = 0;

              // if (flag[3] == '0') {
              //   flag[3] = '1';

              //   print('liked');
              // } else {
              //   print('already done');
              // }
            },
            child: Obx(
              () => AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: 40,
                  height: 40,
                  child: flag.value == 0
                      ? Icon(
                          Icons.favorite_border,
                          color: Colors.blueGrey,
                          size: 30,
                        )
                      : const Icon(Icons.favorite,
                          color: Colors.red, size: 30)),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 100,
              height: 40,
              child: GestureDetector(
                  onTap: () {
                    if (report_entry == 0) {
                      Get.snackbar('Repoted ! ⚠️',
                          'The reported posted will be evaluated and thanks for reporting');
                      report_entry = 1;
                    } else {
                      Get.snackbar('Finished your limit ! ⚠️', '');
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 80,
                      color: Colors.blueGrey,
                      padding: EdgeInsets.only(
                          left: 13, right: 13, top: 10, bottom: 10),
                      child: Text(
                        "Report post",
                        style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ))),
        )
      ],
    );
  }
}
