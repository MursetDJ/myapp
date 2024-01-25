import 'package:flutter/material.dart';
import 'package:myapp/register/register_dialog.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "CONAINGEO",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
            child: TextButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.brown.shade100)),
              onPressed: () {},
              icon: const Icon(Icons.door_back_door),
              label: const Text("Ingresar"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50),
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return  RegisterDialog(context: context);
                  },
                );
              },
              icon: const Icon(Icons.supervised_user_circle),
              label: const Text(
                "INSCRIPCIONES",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
