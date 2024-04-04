import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:myapp/repository/perfil/perfil_repository.dart';
import 'package:myapp/ui/menu/drawer_menu.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';
import 'package:myapp/ui/perfil/backend/perfil_get_provider.dart';
import 'package:provider/provider.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            PerfilProvider(perfilRepo: context.read<PerfilReposiroty>())..get(),
        child: const PerfilScreen._(),
      );
  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    final perfil = context.watch<PerfilProvider>().perfil;
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        appBar: menuAppBar(space, context),
        drawer: const DrawerMenuWeb(),
        body: perfil == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: space.maxHeight,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Color.fromARGB(255, 110, 110, 110)
                ])),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(90))),
                            child: const ImageNetwork(
                                curve: Curves.bounceIn,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                                image:
                                    "http://localhost:8000/documents/dwdw/perfilhero-img.webp",
                                height: 200,
                                width: 200,
                                fitWeb: BoxFitWeb.cover),
                          ),
                        ),
                      ),
                      datos("NOMBRES Y APELLIDOS: ",
                          "${perfil.nombre} ${perfil.apellido}", Icons.person),
                      if (perfil.inscription == "GRUPAL")
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.accessibility_new_outlined,
                                color: Colors.white,
                              ),
                              const Text.rich(TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  text: "TIPO DE INSCRIPCIÓN: ",
                                  children: [
                                    TextSpan(
                                        text: "GRUPAL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ])),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        )
                      else
                        datos("TIPO DE INSCRIPCIÓN: ", perfil.inscription,
                            Icons.accessibility_new_outlined),
                      datos("UNIVERSIDAD: ", perfil.university,
                          Icons.store_outlined),
                      datos("COREO: ", perfil.correo, Icons.mail),
                      datos("DNI: ", perfil.dni, Icons.account_box_rounded),
                      datos("${perfil.tipoProEstEgre}: ",
                          perfil.conceptotipoProEstEgre, Icons.school),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.accessibility_new_outlined,
                              color: Colors.white,
                            ),
                            Text.rich(TextSpan(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                text: "ASISTENCIA: ",
                                children: [
                                  TextSpan(
                                      text:
                                          perfil.asistencia!.length.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ])),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

Padding datos(String typedata, String name, IconData iconorepresentativo) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Icon(
          iconorepresentativo,
          color: Colors.white,
        ),
        Text.rich(TextSpan(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.normal),
            text: typedata,
            children: [
              TextSpan(
                  text: name,
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ])),
      ],
    ),
  );
}
