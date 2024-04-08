import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/repository/auth/auth.dart';
import 'package:myapp/view/design/bodydesign/design_body_colors.dart';
import 'package:myapp/view/input/input_form.dart';
import 'package:myapp/view/menu/footer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final storage = const FlutterSecureStorage();
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");
  bool _activo = true;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Container(
          height: espacio.maxHeight,
          decoration: decoracionFondo(),
          child: Stack(
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/logoConaeingeo.png')),
              SingleChildScrollView(
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
                          fontSize: 30,
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
                          style: const TextStyle(color: Colors.white),
                          onSubmitted: _activo == false
                              ? null
                              : (value) async {
                                  _activo = true;
                                  final shared =
                                      await SharedPreferences.getInstance();

                                  await Auth()
                                      .signInwithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text)
                                      .then((value) {
                                    if (value != null) {
                                      final data = shared.setString(
                                          'BearerTokken', value);

                                      storage.write(
                                          key: "BearerTokken", value: value);
                                      Navigator.of(context).pushNamed('/menu');
                                    } else {
                                      dialogoError(context, espacio);
                                    }
                                  });

                                  _activo = false;
                                },
                          autofillHints: const [AutofillHints.email],
                          controller: _emailController,
                          decoration: inputTextname(
                              "CORREO ELECTRÓNICO",
                              const Icon(
                                Icons.person,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                            style: const TextStyle(color: Colors.white),
                            onSubmitted: _activo == false
                                ? null
                                : (value) async {
                                    _activo = true;
                                    await Auth()
                                        .signInwithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      if (value != null) {
                                        storage.write(
                                            key: "BearerTokken", value: value);
                                        Navigator.of(context)
                                            .pushNamed('/menu');
                                      } else {
                                        dialogoError(context, espacio);
                                      }
                                    });

                                    _activo = false;
                                  },
                            controller: _passwordController,
                            obscureText: true,
                            autofillHints: const [AutofillHints.password],
                            decoration: inputTextname(
                                "CONTRASEÑA",
                                const Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 50, right: 50, bottom: 20),
                      child: TextButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.black))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            foregroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 0, 140, 255))),
                        onPressed: _activo == false
                            ? null
                            : () async {
                                _activo = true;
                                await Auth()
                                    .signInwithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text)
                                    .then((value) {
                                  if (value != "") {
                                    storage.write(
                                        key: "BearerTokken", value: value);
                                    Navigator.of(context).pushNamed('/menu');
                                  } else {
                                    dialogoError(context, espacio);
                                  }
                                });

                                _activo = false;
                              },
                        icon: const Icon(Icons.door_back_door),
                        label: const Text("Ingresar"),
                      ),
                    ),
                    const FooterMenu()
                  ],
                ),
              ),
            ],
          ));
    });
  }
}

Future<dynamic> dialogoError(BuildContext context, BoxConstraints espacio) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        width: espacio.maxWidth * 0.35,
        height: espacio.maxHeight * 0.25,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                textAlign: TextAlign.center,
                "USUARIO O CONTRASEÑA INCORRECTA, POR FAVOR INTENTAR NUEVAMENTE",
                style: TextStyle(color: Colors.red),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      side: MaterialStatePropertyAll(BorderSide(
                          color: Colors.white,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignInside)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("SALIR")),
            )
          ],
        ),
      ),
    ),
  );
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