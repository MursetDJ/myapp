import 'package:flutter/material.dart';

InputDecoration inputTextname(String name, Icon icons) {
  return InputDecoration(
      label: Row(
        children: [
          icons,
          Text(name),
        ],
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
}
