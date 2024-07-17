
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar({String? title, String? message}) {
  if(!Get.isSnackbarOpen){
    Get.showSnackbar(
      GetSnackBar(
        title: (title??"").isNotEmpty ?  title : "Upss..",
        message: message,
        duration: const Duration(seconds: 3),

      ),
    );
  }
}

vspace(double? size) {
  return SizedBox(
    height: size,
  );
}

hspace(double? size) {
  return SizedBox(
    width: size,
  );
}
