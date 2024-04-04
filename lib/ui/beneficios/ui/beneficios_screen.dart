import 'package:flutter/material.dart';
import 'package:myapp/ui/beneficios/carrusel/carrusel_cobre.dart';
import 'package:myapp/ui/beneficios/carrusel/carrusel_oro.dart';
import 'package:myapp/ui/beneficios/carrusel/carrusel_plata.dart';
import 'package:myapp/ui/design/bodydesign/design_body_colors.dart';
import 'package:myapp/ui/menu/drawer_menu.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';

class BeneficiosScreen extends StatefulWidget {
  const BeneficiosScreen({super.key});

  @override
  State<BeneficiosScreen> createState() => _BeneficiosScreenState();
}

class _BeneficiosScreenState extends State<BeneficiosScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        drawer: const DrawerMenuWeb(),
        appBar: menuAppBar(space, context),
        body: DecoratedBox(
          decoration: decoracionFondo(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "BENEFICIOS DE AUSPICIADORES ORO",
                    style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontSize: 30,
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CarruselOro(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "BENEFICIOS DE AUSPICIADORES PLATA",
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 25,
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CarruselPlata(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "BENEFICIOS DE AUSPICIADORES COBRE",
                    style: TextStyle(
                        color: Colors.yellow.shade800,
                        fontSize: 20,
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(0, 2))
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CarruselCobre(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
