import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/register_firebase.dart';
import 'package:myapp/repository/auth/auth.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/buttonCard/button_style.dart';
import 'package:myapp/ui/menu/app_menu.dart';
import 'package:myapp/ui/menu/menu_screen.dart';
import 'package:myapp/ui/register/register_screen.dart';
import 'package:myapp/ui/users/user_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'ui/registrados/registrados.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<RegisterRepository>(
            create: (_) => RegisterFirebase(),
          ),
        ],
        child: MaterialApp(
          initialRoute: Auth().inSession() ? '/menu' : '/login',
          routes: {
            '/register': (context) => RegisterScreen.init(),
            '/login': (context) => const MyHomePage(title: "CONAEINGEO"),
            '/menu': (context) => const MenuScreen(),
            '/listregister': (context) => RegisterDetailsScreenState.init()
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          drawer: constraints.maxWidth < 700 ? const MenuWeb() : null,
          appBar: AppBar(
            actions: constraints.maxWidth >= 700
                ? [
                    TextButton.icon(
                        style: designButton(),
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text("CONTACTOS")),
                    TextButton.icon(
                        style: designButton(),
                        onPressed: () {},
                        icon: const Icon(Icons.wallet),
                        label: const Text("PAGOS"))
                  ]
                : null,
            backgroundColor: Colors.blue,
            title: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                      blurRadius: 2, color: Colors.black, offset: Offset(0, 1))
                ],
              ),
            ),
          ),
          body: const UserScreen(),
        );
      },
    );
  }
}
