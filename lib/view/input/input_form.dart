import 'package:flutter/material.dart';

InputDecoration inputTextname(String name, Icon icons) {
  return InputDecoration(
      label: Row(
        children: [
          icons,
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
}
