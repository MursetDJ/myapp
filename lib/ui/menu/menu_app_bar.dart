import 'package:flutter/material.dart';
import 'package:myapp/ui/buttonCard/button_style.dart';

AppBar menuAppBar(BoxConstraints space) {
  return AppBar(
    backgroundColor: Colors.blue.shade800,
    title: const Text(
      "MENÚ",
      style: TextStyle(color: Colors.white),
    ),
    actions: space.maxWidth >= 700
        ? [
            TextButton.icon(
                style: designButton(),
                onPressed: () {},
                icon: const Icon(Icons.account_circle_sharp),
                label: const Text("PERFIL")),
            TextButton.icon(
                style: designButton(),
                onPressed: () {},
                icon: const Icon(Icons.bento_rounded),
                label: const Text("BENEFICIOS")),
            TextButton.icon(
                style: designButton(),
                onPressed: () {},
                icon: const Icon(Icons.edit_calendar),
                label: const Text("ASISTENCIA")),
          ]
        : null,
  );
}
