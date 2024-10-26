import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWidgetSnackbar {
  static myTemplateSnackBarError({required String title, required String message}) {
    return Flushbar(
      title: title,
      message: message,
      isDismissible: true,
      duration: Duration(seconds: 1),
      // backgroundColor: Colors.,
      leftBarIndicatorColor: Colors.red,
    ).show(Get.context!);
  }

  static myTemplateSnackBarSuccess({required String title, required String message}) {
    return Flushbar(
      title: title,
      message: message,
      isDismissible: true,
      duration: Duration(seconds: 1),
      // backgroundColor: Colors.,
      leftBarIndicatorColor: Colors.green,
    ).show(Get.context!);
  }
}
