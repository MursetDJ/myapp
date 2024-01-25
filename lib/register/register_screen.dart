import 'package:flutter/material.dart';
import 'package:myapp/register/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, espacio) {
          return Column(
            children: [
              const CabeceraScreen(),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: espacio.maxWidth * 0.5,
                child: const Text("Estimada comunidad geológica ⚒️💎"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: espacio.maxWidth * 0.5,
                child: const Text.rich(
                  TextSpan(
                    text:
                        "Estamos sinceramente agradecidos y muy felices de contar con tu participación en este",
                    children: [
                      TextSpan(
                        text: "XIII CONAEINGEO 2024!!!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text:
                              "🤗 Desde ya la Universidad Nacional de Cajamarca te espera y dispuestos a brindarte la mejor experiencia.\nInscríbete ahora y sé parte de esta gran aventura llena de nuevos aprendizajes y conocimientos 🎓"),
                      TextSpan(
                        text:
                            "\n¡CAJAMARCA: La capital del carnaval peruano te espera! 😎",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
