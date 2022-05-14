import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:ventpost/view/home_page.dart';
import 'package:ventpost/view/page.dart';
import 'package:ventpost/view/trending_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ventpost/view/userdetails_edit.dart';
import 'package:platform_device_id/platform_device_id.dart';

final FirebaseController = Get.put(FirebaseControl());
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidDeviceInfo? androidDeviceInfo;

class Controllerhm extends GetxController {
  List a = [];
  List likelist = [].obs;
  RxInt t = 0.obs;
  RxInt pos = 3.obs;
  RxString greeting = "".obs;
  RxString imagelink = "".obs;
  @override
  void onInit() {
    firebase_controller.getuserdetailsfun();
    final now = DateTime.now();
    t.value = now.hour;
    bool morning = t.value >= 4;
    bool afternoon = t.value >= 12;
    bool evening = t.value >= 15;
    bool night = t.value >= 21;

    change(t, morning, afternoon, evening, night);
    FirebaseController.streamController.stream.listen((event) {
      a = event;
    });
    Future.delayed(Duration(seconds: 3), () {
      for (var i = 0; i < a.length; i++) {
        var b = a[i][7];
        var c = a[i][8];
        var z = "[$b,$c]";
        likelist.add(z);
      }
    });
    getid();
    super.onInit();
  }

  change(t, morning, afternoon, evening, night) {
    if (morning) {
      imagelink.value = "4.svg";
      greeting.value = "Good morning ";
      pos.value = 3;
    }
    if (afternoon) {
      imagelink.value = "2.svg";
      greeting.value = "Good afternoon ";
      pos.value = 3;
    }
    if (evening) {
      imagelink.value = "3.svg";
      greeting.value = "Good evening ";
      pos.value = 3;
    }
    if (night) {
      imagelink.value = "4.svg";
      greeting.value = "Good night ";
      pos.value = 100;
    }
  }

  var count = 0.obs;

  var userid = ''.obs;
  Future<void> getid() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    userid.value = deviceId!;
  }

  increment(index) {
    count.value = index;
    if (index == 0) {
      Get.to(() => const HomePage(),
          transition: Transition.leftToRight, duration: Duration(seconds: 1));
    } else if (index == 1) {
      Get.to(() => const TrendingPage(),
          transition: Transition.leftToRight, duration: Duration(seconds: 1));
    } else if (index == 2) {
      Get.to(() => UserDetailsedit(),
          transition: Transition.leftToRight, duration: Duration(seconds: 1));
    }
  }
}
