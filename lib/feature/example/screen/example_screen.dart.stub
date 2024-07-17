import 'package:cgen/cores/base/base_view.dart';
import 'package:cgen/feature/example/controller/example_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleScreen extends BaseView<ExampleController> {
  const ExampleScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(controller.title),
          ),
        ),
      ),
    );
  }
}
