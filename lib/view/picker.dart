import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ventpost/controller/userdeatils_edit_controller.dart';

final userEditController = Get.find<UserdetailsEditController>();

class AgePicker extends StatefulWidget {
  const AgePicker({Key? key}) : super(key: key);

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  var age = [for (var i = 14; i < 120; i += 1) i.toString()];

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
          child: Column(
        children: [
          SizedBox(
            height: 350,
            child: CupertinoPicker(
                itemExtent: 64,
                onSelectedItemChanged: (i) {
                  userEditController.age.value = age[i].toString();
                },
                children: [
                  for (var i in age) Center(child: Text(i.toString()))
                ]),
          ),
        ],
      ));
}
