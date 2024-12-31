import 'package:flutter/material.dart';

class CustomAppBar {
  // const CustomAppBar({super.key});

  // @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Text(
      "Custom",
      style: TextStyle(color: Colors.black),
    ));
  }
}
