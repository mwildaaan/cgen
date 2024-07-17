import 'package:cgen/app.dart';
import 'package:cgen/cores/utils/initializer.dart';
import 'package:flutter/material.dart';

void main() async {

  await Initializer().init();

  runApp(const MyApp());
}