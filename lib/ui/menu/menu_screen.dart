import 'package:flutter/material.dart';
import 'package:myapp/ui/menu/drawer_menu.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        drawer: const DrawerMenuWeb(),
        appBar: menuAppBar(space),
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                customElevatedButton(
                    onPressed: () => {},
                    buttonText: "MI PERFIL",
                    icon: Icons.account_circle),
                customElevatedButton(
                    onPressed: () => {},
                    buttonText: "VER MIS BENEFICIOS",
                    icon: Icons.bento),
                customElevatedButton(
                    onPressed: () => {},
                    buttonText: "VER MIS ASISTENCIAS",
                    icon: Icons.edit_calendar_rounded),
                customElevatedButton(
                    onPressed: () => {},
                    buttonText: "VER VIDEOS",
                    icon: Icons.video_collection_sharp),
                customElevatedButton(
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/listregister')},
                    buttonText: "LISTA DE INSCRITOS",
                    icon: Icons.list_alt),
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
  }
}

Widget customElevatedButton(
    {required Function onPressed,
    required String buttonText,
    required IconData icon}) {
  return Container(
    width: 150,
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
