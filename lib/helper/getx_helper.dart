import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXHelper {
  static showSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.white,
      message: message,
      messageText: Text(message, style: const TextStyle(color: Colors.black)),
    ));
  }
}
