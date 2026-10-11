import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseState<T extends StatefulWidget, C> extends State<T> {
  late final String? tag;
  late final C controller;

  C buildController();

  @override
  void initState() {
    super.initState();
    tag = getTag();
    controller = Get.put<C>(buildController(), tag: tag);
  }

  String? getTag() => null;

  @override
  void dispose() {
    Get.delete<C>(tag: tag);
    super.dispose();
  }
}
