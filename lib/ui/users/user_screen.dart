import 'package:flutter/material.dart';
import 'package:myapp/repository/auth/auth.dart';
import 'package:myapp/ui/input/input_form.dart';
import 'package:myapp/ui/menu/footer_menu.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Container(
        height: espacio.maxHeight,
        color: Colors.blue.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "XIII CONAEINGEO 2024",
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.black,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    autofillHints: const [AutofillHints.email],
                    controller: _emailController,
                    decoration: inputTextname(
                        "CORREO ELECTRÓNICO", const Icon(Icons.person)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      autofillHints: const [AutofillHints.password],
                      decoration:
                          inputTextname("CONTRASEÑA", const Icon(Icons.key))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
                child: TextButton.icon(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black))),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      foregroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 0, 140, 255))),
                  onPressed: () async {
                    Auth()
                        .signInwithEmailAndPassword(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushNamed('/menu');
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const Text("data"),
                        );
                      }
                    });
                  },
                  icon: const Icon(Icons.door_back_door),
                  label: const Text("Ingresar"),
                ),
              ),
              const FooterMenu()
            ],
          ),
        ),
      );
    });
  }
}
/*
 Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return RegisterDialog(context: context);
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
*/