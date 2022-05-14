import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:ventpost/controller/firebase.dart';

final firbasecontrol = Get.put(FirebaseControl());

class UserdetailsEditController extends GetxController {
  var username = 'anon'.obs;
  var gender = 'm'.obs;
  var age = '18'.obs;
  var country_code = 'us'.obs;
  var country = 'United States'.obs;
  var icong = 'lib/assets/m.png'.obs;
}
