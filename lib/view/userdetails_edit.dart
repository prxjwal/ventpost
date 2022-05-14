import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/controller/userdeatils_edit_controller.dart';
import 'package:ventpost/model/bottom_nav_bar.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:ventpost/view/picker.dart';
import 'package:get_storage/get_storage.dart';

final userEditController = Get.put(UserdetailsEditController());
final firbasecontrol = Get.put(FirebaseControl());
final data = GetStorage();

class UserDetailsedit extends StatefulWidget {
  const UserDetailsedit({Key? key}) : super(key: key);

  @override
  _UserDetailseditState createState() => _UserDetailseditState();
}

class _UserDetailseditState extends State<UserDetailsedit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Bottomnavbar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: ClayContainer(
                width: 100,
                height: 100,
                borderRadius: 300,
                child: Center(
                    child: Obx(() => Image.asset(
                          'lib/assets/${userEditController.gender}.png',
                          height: 80,
                          width: 50,
                        ))),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ClayContainer(
              borderRadius: 10,
              child: SizedBox(
                width: Get.width - 50,
                height: 50,
                child: TextField(
                  // keyboardType: TextInputType.visiblePassword,
                  onChanged: (val) {
                    userEditController.username.value = val;
                  },
                  maxLength: 25,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: userEditController.username.value,
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 3, color: Colors.grey),
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClayContainer(
                  borderRadius: 10,
                  child: Container(
                      width: Get.width - 300,
                      height: 50,
                      child: Obx(() => GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => CupertinoActionSheet(
                                        actions: [AgePicker()],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          child: Text('Done'),
                                          onPressed: () {
                                            navigator!.pop(context);
                                          },
                                        ),
                                      ));
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                userEditController.age.value,
                                style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                )),
                              )),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all()),
                            ),
                          ))),
                ),
                ClayContainer(
                  borderRadius: 10,
                  child: Container(
                      width: Get.width - 160,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CountryListPick(
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                title: Text('Pick your country'),
                              ),
                              theme: CountryTheme(
                                alphabetSelectedBackgroundColor: Colors.black,
                                alphabetTextColor: Colors.black,
                                alphabetSelectedTextColor: Colors.white,
                                isShowFlag: true,
                                isShowTitle: true,
                                isShowCode: false,
                                isDownIcon: false,
                                showEnglishName: true,
                                labelColor: Colors.black,
                              ),
                              initialSelection: userEditController
                                  .country_code.value
                                  .toUpperCase(),
                              onChanged: (code) {
                                userEditController.country_code.value =
                                    code!.code!.toLowerCase();
                                userEditController.country.value = code.name!;
                              },
                            ),
                          ),
                          // Obx(() => Expanded(
                          //     child:
                          //         Text(userEditController.country.value)))
                        ],
                      )),
                )
              ],
            ),
            ClayContainer(
              width: Get.width - 50,
              height: 50,
              borderRadius: 10,
              child: Container(
                width: Get.width - 50,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          userEditController.gender.value = 'm';
                          userEditController.icong.value = 'lib/assets/m.png';
                        },
                        child: Container(
                          child: Icon(
                            Icons.male_rounded,
                            color: Colors.blueAccent,
                            size: 30,
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                            color: userEditController.gender.value == 'm'
                                ? Colors.grey.withOpacity(0.3)
                                : null,
                            border: Border.all(width: 0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          userEditController.gender.value = 'f';
                          userEditController.icong.value = 'lib/assets/f.png';
                        },
                        child: Container(
                          child: Icon(
                            Icons.female_rounded,
                            color: Colors.pinkAccent,
                            size: 30,
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                              color: userEditController.gender.value == 'f'
                                  ? Colors.grey.withOpacity(0.3)
                                  : null,
                              border: Border.all(width: 0)),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          userEditController.gender.value = 'o';
                          userEditController.icong.value = 'lib/assets/o.png';
                        },
                        child: Container(
                          child: Icon(
                            Icons.transgender_rounded,
                            size: 25,
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                              color: userEditController.gender.value == 'o'
                                  ? Colors.grey.withOpacity(0.3)
                                  : null,
                              border: Border.all(width: 0),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("object");
              },
              child: ClayContainer(
                borderRadius: 10,
                child: Container(
                  width: Get.width - 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black38,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                                cancelButton: CupertinoActionSheetAction(
                                  child: Container(
                                      height: 50,
                                      width: 80,
                                      color: Colors.blueGrey,
                                      child: Text('Done')),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                actions: [AgePicker()],
                              ));
                    },
                    child: GestureDetector(
                      onTap: () {
                        firbasecontrol.setuserdeatils(
                            age: userEditController.age.value,
                            country_code: userEditController.country_code.value,
                            gender: userEditController.gender.value,
                            username: userEditController.username.value);
                      },
                      child: Center(
                          child: Text("Save changes",
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)))),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
