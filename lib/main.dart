import 'package:flutter/material.dart';
import 'package:myapp/menu/app_menu.dart';
import 'package:myapp/users/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CONAINGEO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CONAINGEO'),
    );
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
                       TextButton.icon(onPressed: (){}, icon: const Icon(Icons.person), label: const Text("REGISTRARSE"))
                         ,TextButton.icon(onPressed: (){}, icon: const Icon(Icons.phone), label: const Text("CONTACTOS"))
                        ,TextButton.icon(onPressed: (){}, icon: const Icon(Icons.wallet), label: const Text("PAGOS"))
                     ]
                  
                : null,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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


/*Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://mextudia.com/wp-content/uploads/2019/06/pexels-photo-1533466-e1561320476229.jpg",
                    width: 60,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),*/