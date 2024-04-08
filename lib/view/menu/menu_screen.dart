import 'package:flutter/material.dart';
import 'package:myapp/view/design/bodydesign/design_body_colors.dart';
import 'package:myapp/view/menu/drawer_menu.dart';
import 'package:myapp/view/menu/menu_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int validarsesion = 1;
  int rol = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shared = await SharedPreferences.getInstance();
      rol = shared.getInt('User')!;
      shared.getString('BearerTokken') != null
          ? validarsesion = 2
          : validarsesion = 3;
      actualizar();
    });
    super.initState();
  }

  @override
  void dispose() {
    validarsesion = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (validarsesion == 2) {
      return LayoutBuilder(builder: (context, space) {
        return Scaffold(
          drawer: const DrawerMenuWeb(),
          appBar: menuAppBar(space, context),
          body: Container(
            decoration: decoracionFondo(),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  if (rol == 0)
                    customElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/perfil')},
                        buttonText: "MI PERFIL",
                        icon: Icons.account_circle),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () => {
                              Navigator.of(context).pushNamed('/listbeneficios')
                            },
                        buttonText: "ADMINISTRAR BENEFICIOS",
                        icon: Icons.admin_panel_settings_outlined),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/listsalidas')},
                        buttonText: "ADMINISTRAR SALIDAS",
                        icon: Icons.account_circle),
                  customElevatedButton(
                      onPressed: () => {
                            Navigator.of(context).pushNamed('/salidasdirigidas')
                          },
                      buttonText: "SALIDAS DIRIGIDAS",
                      icon: Icons.nordic_walking_sharp),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () => {},
                        buttonText: "REVISTA GEOLÓGICA",
                        icon: Icons.account_circle),
                  customElevatedButton(
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/beneficios')},
                      buttonText: "VER MIS BENEFICIOS",
                      icon: Icons.bento),
                  customElevatedButton(
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/asistencia')},
                      buttonText: "VER MIS ASISTENCIAS",
                      icon: Icons.edit_calendar_rounded),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed('/listconferencias')
                            },
                        buttonText: "ADMINSTRAR CONFERENCIAS",
                        icon: Icons.account_circle),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/listponentes')},
                        buttonText: "ADMINISTRAR PONENTES",
                        icon: Icons.contact_phone_rounded),
                  customElevatedButton(
                      onPressed: () => {},
                      buttonText: "VER VIDEOS",
                      icon: Icons.video_collection_sharp),
                  customElevatedButton(
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/ponentes')},
                      buttonText: "PONENTES",
                      icon: Icons.co_present_outlined),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/listregister')},
                        buttonText: "LISTA DE INSCRITOS",
                        icon: Icons.list_alt),
                  if (rol == 1 || rol == 2)
                    customElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/register')},
                        buttonText: "INSCRIBIR",
                        icon: Icons.insert_drive_file),
                ],
              ),
            ),
          ),
        );
      });
    } else {
      if (validarsesion == 3) {
        return Center(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(width: 20, color: Colors.black)),
          child: const Text(
            "NO SE TIENEN PERMISOS NECESARIOS PARA ACCEDER",
            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black87,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
        ));
      }
      return const SizedBox();
    }
  }

  Future<void> actualizar() async {
    setState(() {});
  }
}

Widget customElevatedButton(
    {required Function onPressed,
    required String buttonText,
    required IconData icon}) {
  return Container(
    width: 160,
    height: 95,
    margin: const EdgeInsets.fromLTRB(10, 15, 0, 15),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      onPressed: () => onPressed(),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 50),
          Text(
            buttonText,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
