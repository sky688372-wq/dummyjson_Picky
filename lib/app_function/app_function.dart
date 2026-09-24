import 'package:dummyjson/app_color/app_color.dart';
import 'package:flutter/material.dart';

class AppFunction {
  //개발 중임을 표시하는 함수
  static void showBuilding(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.primary,
        content: Text(
          "해당 기능은 현재 개발중인 기능입니다.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white
          ),
        ),
      )
    );
  }
}