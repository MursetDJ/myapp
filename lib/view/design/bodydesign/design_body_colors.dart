import 'package:flutter/material.dart';

BoxDecoration decoracionFondo() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(255, 18, 79, 194),
        Color.fromARGB(255, 5, 25, 120)
      ],
    ),
  );
}
