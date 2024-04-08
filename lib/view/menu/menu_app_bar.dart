import 'package:flutter/material.dart';
import 'package:myapp/view/buttonCard/button_style.dart';

AppBar menuAppBar(BoxConstraints space, BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).pushNamed('/perfil');
                },
                icon: const Icon(Icons.account_circle_sharp),
                label: const Text("PERFIL")),
            TextButton.icon(
                style: designButton(),
                onPressed: () {
                  Navigator.of(context).pushNamed('/menu');
                },
                icon: const Icon(Icons.menu_open),
                label: const Text("MENÚ")),
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
