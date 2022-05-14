import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Column(
      children: const [
         Flag.fromString('AD', height: 10, width: 100, fit: BoxFit.fill),
      ],
    ),);
  }
}