import 'package:flutter/material.dart';
import 'package:myapp/repository/auth/auth.dart';
import 'package:myapp/view/buttonCard/button_style.dart';

class DrawerMenuWeb extends StatelessWidget {
  const DrawerMenuWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(106, 33, 149, 243),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Image.asset(
                  "assets/logoConaeingeo.png",
                  width: 60,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                  style: designButton(),
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_sharp),
                  label: const Text("PERFIL")),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                  style: designButton(),
                  onPressed: () {},
                  icon: const Icon(Icons.bento_rounded),
                  label: const Text("BENEFICIOS")),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                  style: designButton(),
                  onPressed: () {},
                  icon: const Icon(Icons.edit_calendar),
                  label: const Text("ASISTENCIA")),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                  style: designButton(),
                  onPressed: () {
                    Auth().cerrarsesion(context);
                  },
                  icon: const Icon(Icons.power_settings_new),
                  label: const Text("CERRAR SESIÓN")),
            ),
          ],
        ));
  }
}
