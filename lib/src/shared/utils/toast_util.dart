import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  ToastUtil._();

  static void showMess({required String mess, ToastGravity? gravy}) {
    Fluttertoast.showToast(
      msg: mess,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravy ?? ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
