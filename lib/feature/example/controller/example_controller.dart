import 'dart:convert';

import 'package:cgen/cores/base/base_controller.dart';
import 'package:cgen/feature/example/argument/example_argument.dart';
import 'package:cgen/feature/example/model/example_model.dart';
import 'package:cgen/feature/example/repository/example_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class ExampleController extends BaseController {
  final ExampleRepository exampleRepository =
      Get.find(tag: (ExampleRepository).toString());
  ExampleArgument? exampleArgument;

  final RxString _titleController = RxString("Example");

  String get title => _titleController.value;

  @override
  void onInit() {
    // TODO: implement onInit
    exampleArgument = Get.arguments;
    debugPrint("Example Argument => ${exampleArgument?.id}");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

/*void getExampleData(){
    var exampleDataService = exampleRepository.getDataFromApi();

    callDataService(
      exampleDataService,
      onSuccess: _handleDataExampleList
    );
  }

  void _handleDataExampleList(List<YourModelList> yourModelList){
    _exampleListController(yourModelList);
  }*/
}
