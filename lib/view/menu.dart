import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventpost/controller/home_page_controller.dart';
import 'package:get/get.dart';
import 'package:ventpost/controller/userdeatils_edit_controller.dart';

final hmcontroller = Get.put(Controllerhm());
final userEditController = Get.put(UserdetailsEditController());
RxString il = hmcontroller.imagelink;
RxString user = userEditController.username;
// import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Obx(
              () => SvgPicture.asset(
                'lib/assets/$il',
              ),
            ),
            Obx(() => Positioned(
                  top: hmcontroller.pos.value.toDouble(),
                  right: 3,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 1,
                        child: Container(
                          width: 225,
                          height: 60,
                          color: Color(0xffF3CEA1).withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Text(
                                hmcontroller.greeting.value + '' + user.value,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          )),
                    ],
                  ),
                ))
          ],
        ));
  }
}
