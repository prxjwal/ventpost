import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ventpost/controller/home_page_controller.dart';
import 'package:ventpost/controller/post_controller.dart';
import 'package:ventpost/controller/userdeatils_edit_controller.dart';
import 'package:intl/intl.dart';
import 'package:ventpost/view/picker.dart';

final hmcontroller = Get.put(Controllerhm());
final userEditController = Get.put(UserdetailsEditController());
final postcontroller = Get.put(Pcontroller());
final accountController = Get.put(UserdetailsEditController());
DateTime now = DateTime.now();
String formattedDate = DateFormat('kk-mm-ss').format(now);
var likecount;
var likedata;

class FirebaseControl extends GetxController {
  List final_trend_year = [].obs;
  List final_trend_a = [].obs;
  List final_trend_m = [].obs;
  List like_list = [].obs;
  List getuserdetails = [].obs;

  List incoming_list = [];
  List controllist = [].obs;
  List datalist = [].obs;
  List count_list = [].obs;
  List cntlist = [].obs;
  List trend_year = [].obs;
  var tempdata;
  final StreamController streamController = StreamController.broadcast();

  RxMap<dynamic, dynamic> raw = {}.obs;

  RxMap<dynamic, dynamic> rawd = {}.obs;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("main");
  static final DocumentReference documentReference =
      collectionReference.doc("input");
  static final CollectionReference collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc('Anon')
      .collection('data');
  static final CollectionReference userdetails =
      FirebaseFirestore.instance.collection('users');
  static final DocumentReference documentRef = collectionRef.doc('data');
  static final CollectionReference trenddocs =
      FirebaseFirestore.instance.collection('trending');

  getdata() {
    documentRef.snapshots().listen((snapshot) {
      raw.value = snapshot.data() as Map<dynamic, dynamic>;

      incoming_list = raw.values.toList();
      datalist = incoming_list;
      streamController.sink.add(incoming_list);
    });
  }

  gettrend_y() {
    trenddocs.doc('year').snapshots().listen((snapshot) {
      var temptrend = snapshot.data() as Map<dynamic, dynamic>;
      var trend = temptrend.values.toList()[0];
      for (var i = 0; i < trend.length; i++) {
        final_trend_year.add(trend[i].values.toList()[0]);
      }
    });
  }

  gettrend_all() {
    trenddocs.doc('all-time').snapshots().listen((snapshot) {
      var temptrenda = snapshot.data() as Map<dynamic, dynamic>;
      var trenda = temptrenda.values.toList()[0];
      for (var i = 0; i < trenda.length; i++) {
        final_trend_a.add(trenda[i].values.toList());
      }
      final_trend_a = final_trend_a[0];
    });
  }

  gettrend_m() {
    trenddocs.doc('month').snapshots().listen((snapshot) {
      var temptrendM = snapshot.data() as Map<dynamic, dynamic>;

      var trendm = temptrendM.values.toList()[0];

      for (var i = 0; i < trendm.length; i++) {
        final_trend_m.add(trendm[i].values.toList()[0]);
      }
    });
  }

  initailliked() {
    FirebaseFirestore.instance
        .collection('data')
        .add({hmcontroller.userid.value: 'data added through app'});
  }

  setuserdeatils(
      {required String username,
      required String country_code,
      required String age,
      required String gender}) {
    userdetails.doc('useranon').set({
      'Country_code': country_code,
      'gender': gender,
      'age': age,
      'username': username
    });
  }

  getuserdetailsfun() {
    userdetails.doc('useranon').snapshots().listen((snapshot) {
      var tempuserdetails = snapshot.data() as Map<dynamic, dynamic>;
      getuserdetails = tempuserdetails.values.toList();
      print(getuserdetails);
      userEditController.country_code.value = getuserdetails[0];
      userEditController.gender.value = getuserdetails[1];
      userEditController.age.value = getuserdetails[2];
      userEditController.username.value = getuserdetails[3];
      if (getuserdetails[2] == "f") {
        userEditController.icong.value = 'lib/assets/female.png';
      }
      if (getuserdetails[2] == "o") {
        userEditController.icong.value = 'lib/assets/trans.png';
      }
    });
  }

  post_like({required var postid}) async {
    await FirebaseFirestore.instance
        .collection('record')
        .doc(postid)
        .get()
        .then((value) => tempdata = value.data());

    var i = tempdata.values.toList();

    var a = i[2];

    if (tempdata != null) {
      FirebaseFirestore.instance
          .collection('record')
          .doc(postid)
          .update({'likes': a + 1});
    }
  }

  post_to_main() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk-mm-ss').format(now);
    FirebaseFirestore.instance
        .collection('record')
        .doc(hmcontroller.userid.value + formattedDate)
        .set({
      'likes': 0,
      'timestamp': Timestamp.now(),
      "id": hmcontroller.userid.value + formattedDate
    });

    FirebaseFirestore.instance.collection('main').doc('input').update({
      hmcontroller.userid.value + formattedDate: [
        hmcontroller.userid.value + formattedDate,
        accountController.username.value,
        accountController.age.value,
        accountController.country_code.value,
        postcontroller.title,
        postcontroller.postcardLines,
        postcontroller.letter,
        0
      ]
    });
  }
}
