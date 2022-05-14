import 'package:get/state_manager.dart';
import 'package:ventpost/controller/firebase.dart';
import 'package:get/get.dart';

final FirebaseController = Get.put(FirebaseControl());

class Trending_dart extends GetxController {
  late RxString Value_t = "month".obs;
  var a = FirebaseController.final_trend_a.obs;
}
