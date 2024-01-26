import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:myapp/register/register_header.dart';
import 'package:path/path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController(text: "");
  final _apellidoController = TextEditingController(text: "");
  final _correoController = TextEditingController(text: "");
  final _dniController = TextEditingController(text: "");
  final _integrantesController = TextEditingController(text: "");
  final _otroCiclo = TextEditingController(text: "");
  final _opinionController = TextEditingController(text: "");

  bool visibilidad = false;
  int tipoDato = 1;
  int ciclo = 1;
  File? _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, espacio) {
          return ColoredBox(
            color: Colors.blue.shade100,
            child: Column(
              children: [
                const CabeceraScreen(),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text.rich(
                    TextSpan(
                      text:
                          "Estimada comunidad geológica ⚒️💎\nEstamos sinceramente agradecidos y muy felices de contar con tu participación en este",
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
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text(
                    "NOMBRES:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      label: Text("NOMBRES"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text(
                    "APELLIDOS:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(
                      label: Text("APELLIDOS"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text(
                    "CORREO ELECTRÓNICO:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _correoController,
                    decoration: const InputDecoration(
                      label: Text("CORREO ELECTRÓNICO"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text(
                    "NÚMERO DE DNI:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _dniController,
                    decoration: const InputDecoration(
                      label: Text("DNI"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: DropdownButton(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("ESTUDIANTE"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("EGRESADO"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("PROFESIONAL"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        tipoDato = value!;
                      });
                    },
                    value: tipoDato,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: DropdownButton(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("I Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("II Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("III Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("IV Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 5,
                        child: Text("V Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 6,
                        child: Text("VI Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 7,
                        child: Text("VII Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 8,
                        child: Text("VIII Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 9,
                        child: Text("IX Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 10,
                        child: Text("X Ciclo"),
                      ),
                      DropdownMenuItem(
                        value: 11,
                        child: Text("OTROS"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == 11) {
                          visibilidad = true;
                        } else {
                          visibilidad = false;
                          _otroCiclo.text = "";
                        }
                        ciclo = value!;
                      });
                    },
                    value: ciclo,
                  ),
                ),
                Visibility(
                  visible: visibilidad,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth * 0.5,
                    child: TextField(
                      controller: _otroCiclo,
                      decoration: const InputDecoration(
                        label: Text("OTROS"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: TextButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("INGRESAR IMAGEN"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: TextButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("COMPROBANTE DE PAGO"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: TextButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("INGRESAR CONSTANCIA"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: TextButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("MODALIDAD DE INSCRIPCIÓN"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  width: espacio.maxWidth * 0.5,
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("INDIVIDUAL"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("GRUPAL"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        tipoDato = value!;
                      });
                    },
                    value: tipoDato,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _dniController,
                    decoration: const InputDecoration(
                      label: Text("INTEGRANTES (NOMBRES Y APELLIDOS)"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _dniController,
                    decoration: const InputDecoration(
                      label: Text("RESPUESTA"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.red.shade200),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  width: espacio.maxWidth * 0.5,
                  child: const Text(
                    "Para nosotros es muy importante conocer tu opinión como participante de este gran evento académico 🎓😎¿Qué innovaciones logísticas y/o académicas esperas para este XIII CONAEINGEO 2024?:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.center,
                  width: espacio.maxWidth * 0.5,
                  child: TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      label: Text("NOMBRES"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

void uploadImage(File imageFile) async {
  var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
  var length = await imageFile.length();

  var uri = Uri.parse("http://example.com/upload_image");

  var request = http.MultipartRequest("POST", uri);

  var multipartFile = http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  request.files.add(multipartFile);
  var response = await request.send();
  if (response.statusCode == 200) {
    print("Image Uploaded");
  } else {
    print("Upload Failed");
  }
}
