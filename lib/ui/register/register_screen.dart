import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';
import 'package:myapp/ui/register/REGISTER/upload_files.dart';
import 'package:myapp/ui/register/register_header.dart';
import 'package:myapp/ui/registrados/register_add_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            RegisterAddProvider(regRepo: context.read<RegisterRepository>()),
        child: const RegisterScreen._(),
      );
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

  final _formKey = GlobalKey<FormState>();

  String? university;
  String? typestudent;
  String? ciclestudent;

  bool buttonActive = true;

  int numuniversity = 0;
  bool visibilidad = false;
  bool visibilidadGroup = false;
  int tipoDato = 0;
  int tipoInscription = 0;
  int ciclo = 0;
  String _pickedImage = "";
  Uint8List webImage = Uint8List(8);

  String _filenameConstance = "";
  Uint8List fileConstance = Uint8List(8);

  String selectfile = "";
  Uint8List selectFilePayment = Uint8List(8);

  String _filenameDNI = "";
  Uint8List selectFileDNI = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, espacio) {
          return ColoredBox(
            color: Colors.blue.shade100,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CabeceraScreen(),
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
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
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Por favor, selecciona una opción';
                        }
                        return null;
                      },
                      hint: const Text("SELECCIONA UNIVERSIDAD"),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: SizedBox(
                            width: espacio.maxWidth * 0.50,
                            child: const Text(
                                "UNIVERSIDAD NACIONAL DE SAN ANTONIO ABAD DEL CUSCO"),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: SizedBox(
                            width: espacio.maxWidth * 0.50,
                            child: const Text(
                                "UNIVERSIDAD NACIONAL DANIEL ALCIDES CARRIÓN "),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child: const Text(
                                  "UNIVERSIDAD NACIONAL DE CAJAMARCA")),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child: const Text(
                                  "UNIVERSIDAD NACIONAL DE INGENIERÍA")),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child:
                                  const Text("UNIVERSIDAD NACIONAL DE PIURA")),
                        ),
                        DropdownMenuItem(
                          value: 6,
                          child: SizedBox(
                            width: espacio.maxWidth * 0.50,
                            child: const Text(
                                "UNIVERSIDAD NACIONAL DE SAN AGUSTIN DE AREQUIPA"),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 7,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child: const Text(
                                  "UNIVERSIDAD NACIONAL DEL ALTIPLANO PUNO")),
                        ),
                        DropdownMenuItem(
                          value: 8,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child: const Text(
                                  "UNIVERSIDAD NACIONAL MAYOR DE SAN MARCOS")),
                        ),
                        DropdownMenuItem(
                          value: 9,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child:
                                  const Text("UNIVERSIDAD PRIVADA DEL NORTE")),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: SizedBox(
                              width: espacio.maxWidth * 0.50,
                              child: const Text(
                                  "PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ")),
                        ),
                        DropdownMenuItem(
                          value: 11,
                          child: SizedBox(
                            width: espacio.maxWidth * 0.50,
                            child: const Text(
                                "UNIVERSIDAD NACIONAL JORGE BASADRE GROHMANN"),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          switch (value) {
                            case 1:
                              university =
                                  "UNIVERSIDAD NACIONAL DE SAN ANTONIO ABAD DEL CUSCO";
                              break;
                            case 2:
                              university =
                                  "UNIVERSIDAD NACIONAL DANIEL ALCIDES CARRIÓN";
                              break;
                            case 3:
                              university = "UNIVERSIDAD NACIONAL DE CAJAMARCA";
                              break;
                            case 4:
                              university = "UNIVERSIDAD NACIONAL DE INGENIERÍA";
                              break;
                            case 5:
                              university = "UNIVERSIDAD NACIONAL DE PIURA";
                              break;
                            case 6:
                              university =
                                  "UNIVERSIDAD NACIONAL DE SAN AGUSTIN DE AREQUIPA";
                              break;
                            case 7:
                              university =
                                  "UNIVERSIDAD NACIONAL DEL ALTIPLANO PUNO";
                              break;
                            case 8:
                              university =
                                  "UNIVERSIDAD NACIONAL MAYOR DE SAN MARCOS";
                              break;
                            case 9:
                              university = "UNIVERSIDAD PRIVADA DEL NORTE";
                              break;
                            case 10:
                              university =
                                  "PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ";
                              break;
                            case 11:
                              university =
                                  "UNIVERSIDAD NACIONAL JORGE BASADRE GROHMANN";
                              break;

                            default:
                          }

                          numuniversity = value!;
                        });
                      },
                      value: numuniversity == 0 ? null : numuniversity,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: const Text(
                      "NOMBRES:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce tus nombres';
                        }
                        // Aquí puedes agregar más lógica para validar los nombres
                        final bool apellidoValid = RegExp(
                                r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ]+(([\ ][a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ])?[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ]*)*$')
                            .hasMatch(value);

                        if (!apellidoValid) {
                          return 'Por favor, introduce nombres válidos';
                        }
                        return null;
                      },
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        label: Text("NOMBRES"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: const Text(
                      "APELLIDOS:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce tus apellidos';
                        }
                        // Aquí puedes agregar más lógica para validar los apellidos
                        final bool apellidoValid = RegExp(
                                r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ]+(([\ ][a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ])?[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ]*)*$')
                            .hasMatch(value);

                        if (!apellidoValid) {
                          return 'Por favor, introduce apellidos válidos';
                        }
                        return null;
                      },
                      controller: _apellidoController,
                      decoration: const InputDecoration(
                        label: Text("APELLIDOS"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: const Text(
                      "CORREO ELECTRÓNICO:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un correo electrónico';
                        }
                        final bool emailValid = RegExp(
                                r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Por favor, introduce un correo electrónico válido';
                        }
                        return null;
                      },
                      controller: _correoController,
                      decoration: const InputDecoration(
                        label: Text("CORREO ELECTRÓNICO"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: const Text(
                      "NÚMERO DE DNI:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: TextFormField(
                      maxLength: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un DNI';
                        }
                        // Aquí puedes agregar más lógica para validar el DNI
                        final bool dniValid =
                            RegExp(r'^[0-9]{8}$').hasMatch(value);
                        if (!dniValid) {
                          return 'Por favor, introduce un DNI válido';
                        }
                        return null;
                      },
                      controller: _dniController,
                      decoration: const InputDecoration(
                        label: Text("DNI"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Por favor, selecciona una opción';
                        }
                        return null;
                      },
                      hint: const Text("CONDICIÓN DEL PARTICIPANTE:"),
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
                        switch (value) {
                          case 1:
                            typestudent = "ESTUDIANTE";
                            break;
                          case 2:
                            typestudent = "EGRESADO";
                            break;
                          case 3:
                            fileConstance = Uint8List(8);
                            _filenameConstance = "";
                            typestudent = "PROFESIONAL";
                            break;
                          default:
                        }
                        setState(() {
                          tipoDato = value!;
                        });
                      },
                      value: tipoDato == 0 ? null : tipoDato,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Por favor, selecciona una opción';
                        }
                        return null;
                      },
                      hint: const Text("CICLO DE ESTUDIOS"),
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
                          switch (value) {
                            case 1:
                              ciclestudent = "I CICLO";
                              break;
                            case 2:
                              ciclestudent = "II CICLO";
                              break;
                            case 3:
                              ciclestudent = "III CICLO";
                              break;
                            case 4:
                              ciclestudent = "IV CICLO";
                              break;
                            case 5:
                              ciclestudent = "V CICLO";
                              break;
                            case 6:
                              ciclestudent = "VI CICLO";
                              break;
                            case 7:
                              ciclestudent = "VII CICLO";
                              break;
                            case 8:
                              ciclestudent = "VIII CICLO";
                              break;
                            case 9:
                              ciclestudent = "IX CICLO";
                              break;
                            case 10:
                              ciclestudent = "X CICLO";
                              break;
                            case 11:
                              ciclestudent = "OTRO";
                              break;

                            default:
                          }
                          if (value == 11) {
                            visibilidad = true;
                          } else {
                            visibilidad = false;
                            _otroCiclo.text = "";
                          }
                          ciclo = value!;
                        });
                      },
                      value: ciclo == 0 ? null : ciclo,
                    ),
                  ),
                  Visibility(
                    visible: visibilidad,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.center,
                      width: espacio.maxWidth > 700
                          ? espacio.maxWidth * 0.6
                          : espacio.maxWidth * 0.8,
                      child: TextFormField(
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
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                          width: espacio.maxWidth > 700
                              ? espacio.maxWidth * 0.6
                              : espacio.maxWidth * 0.8,
                          child: const Text.rich(
                            TextSpan(
                                text: "INGRESE ACÁ LA IMAGEN PARA SU PERFÍL",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(0, 2))
                                    ]),
                                children: [
                                  TextSpan(
                                      text:
                                          "\nSolo se permiten formatos de imagen, no se aceptan pdfs u otros")
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _pickedImage.isEmpty
                            ? const Icon(
                                Icons.image,
                                size: 150,
                              )
                            : SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.memory(
                                  webImage,
                                  fit: BoxFit.contain,
                                )),
                        TextButton.icon(
                          onPressed: () async {
                            _selectedImagePerfil();
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text("IMAGEN DE PERFÍL"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                          width: espacio.maxWidth > 700
                              ? espacio.maxWidth * 0.6
                              : espacio.maxWidth * 0.8,
                          child: const Text.rich(
                            TextSpan(
                                text: "COMPROBANTE DE PAGO",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(0, 2))
                                    ]),
                                children: [
                                  TextSpan(
                                      text:
                                          "\nSolo se permiten formatos de imagen y pdfs")
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        selectfile.isEmpty
                            ? const Icon(
                                Icons.document_scanner_outlined,
                                size: 150,
                              )
                            : selectfile.endsWith('.pdf')
                                ? Text(selectfile)
                                : SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.memory(selectFilePayment),
                                  ),
                        TextButton.icon(
                          onPressed: () {
                            _selectedFile();
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text("COMPROBANTE DE PAGO"),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: tipoDato != 3 ? true : false,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      margin: const EdgeInsets.all(5),
                      width: espacio.maxWidth > 700
                          ? espacio.maxWidth * 0.6
                          : espacio.maxWidth * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          SizedBox(
                            width: espacio.maxWidth > 700
                                ? espacio.maxWidth * 0.6
                                : espacio.maxWidth * 0.8,
                            child: const Text.rich(
                              TextSpan(
                                  text: "INGRESAR CONSTANCIA",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            offset: Offset(0, 2))
                                      ]),
                                  children: [
                                    TextSpan(
                                        text:
                                            "\nSolo se permiten formatos de pdfs, no se aceptan imágenes u otros")
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          _filenameConstance.isEmpty
                              ? const Icon(
                                  Icons.edit_document,
                                  size: 150,
                                )
                              : Text(
                                  _filenameConstance,
                                  style: const TextStyle(fontSize: 20),
                                ),
                          TextButton.icon(
                            onPressed: () {
                              _selectedfileConstance();
                            },
                            icon: const Icon(Icons.upload),
                            label: const Text("INGRESAR CONSTANCIA"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: [
                        SizedBox(
                          width: espacio.maxWidth > 700
                              ? espacio.maxWidth * 0.6
                              : espacio.maxWidth * 0.8,
                          child: const Text.rich(
                            TextSpan(
                                text: "FOTO DE CARNET / DNI",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(0, 2))
                                    ]),
                                children: [
                                  TextSpan(
                                      text:
                                          "\nSolo se permiten formatos de imagen")
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _filenameDNI.isEmpty
                            ? const Icon(
                                Icons.edit_document,
                                size: 150,
                              )
                            : Text(
                                _filenameDNI,
                                style: const TextStyle(fontSize: 20),
                              ),
                        TextButton.icon(
                          onPressed: () {
                            _selectedfileDNI();
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text("MODALIDAD DE INSCRIPCIÓN"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Por favor, selecciona una opción';
                        }
                        return null;
                      },
                      hint: const Text("INGRESE LA INSCRIPCIÓN"),
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
                        if (value == 2) {
                          visibilidadGroup = true;
                        } else {
                          visibilidadGroup = false;
                          _integrantesController.text = "";
                        }
                        setState(() {
                          tipoInscription = value!;
                        });
                      },
                      value: tipoInscription == 0 ? null : tipoInscription,
                    ),
                  ),
                  Visibility(
                    visible: visibilidadGroup,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.center,
                      width: espacio.maxWidth > 700
                          ? espacio.maxWidth * 0.6
                          : espacio.maxWidth * 0.8,
                      child: TextFormField(
                        controller: _integrantesController,
                        decoration: const InputDecoration(
                          label: Text("INTEGRANTES (NOMBRES Y APELLIDOS)"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red.shade200),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: const Text(
                      "Para nosotros es muy importante conocer tu opinión como participante de este gran evento académico 🎓😎¿Qué innovaciones logísticas y/o académicas esperas para este XIII CONAEINGEO 2024?:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    alignment: Alignment.center,
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.6
                        : espacio.maxWidth * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese una opinión";
                        }
                        return null;
                      },
                      controller: _opinionController,
                      decoration: const InputDecoration(
                        label: Text("ESCRIBA AQUÍ"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: espacio.maxWidth * 0.3),
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shadowColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: buttonActive
                                ? () async {
                                    buttonActive = false;
                                    if (_formKey.currentState!.validate()) {
                                      if (((ciclo == 11 &&
                                                  _otroCiclo.text.isNotEmpty) ||
                                              (ciclo != 0 &&
                                                  ciclo != 11 &&
                                                  _otroCiclo.text.isEmpty)) &&
                                          ((tipoInscription == 2 &&
                                                  _integrantesController
                                                      .text.isNotEmpty) ||
                                              (tipoInscription == 1 &&
                                                  _integrantesController
                                                      .text.isEmpty)) &&
                                          _pickedImage.isNotEmpty &&
                                          ((tipoDato != 3 &&
                                                  _filenameConstance
                                                      .isNotEmpty) ||
                                              (tipoDato == 3)) &&
                                          _filenameDNI.isNotEmpty &&
                                          selectfile.isNotEmpty) {
                                        await context
                                            .read<RegisterAddProvider>()
                                            .add(
                                              Register(
                                                name: _nombreController.text,
                                                lastname:
                                                    _apellidoController.text,
                                                university: university!,
                                                dni: _dniController.text,
                                                typeStudent: typestudent!,
                                                hotmail: _correoController.text,
                                                cicle: ciclestudent!,
                                                imgPerfil: _pickedImage,
                                                pagoCompr: selectfile,
                                                constance: tipoDato != 3
                                                    ? _filenameConstance
                                                    : "empty",
                                                modality: _filenameDNI,
                                                inscripction:
                                                    _integrantesController
                                                                .text ==
                                                            ""
                                                        ? "INDIVIDUAL"
                                                        : "GRUPAL",
                                                detailInscription:
                                                    _integrantesController.text,
                                                opinion:
                                                    _opinionController.text,
                                              ),
                                            )
                                            .then((value) async {
                                          if (value) {
                                            uploadFiles(
                                                university!,
                                                _pickedImage,
                                                webImage,
                                                _nombreController.text,
                                                _apellidoController.text,
                                                "perfil");

                                            if (tipoDato != 3) {
                                              uploadFiles(
                                                  university!,
                                                  _filenameConstance,
                                                  fileConstance,
                                                  _nombreController.text,
                                                  _apellidoController.text,
                                                  "constancia");
                                            }
                                            uploadFiles(
                                                university!,
                                                _filenameDNI,
                                                selectFileDNI,
                                                _nombreController.text,
                                                _apellidoController.text,
                                                "DNI");
                                            uploadFiles(
                                                university!,
                                                selectfile,
                                                selectFilePayment,
                                                _nombreController.text,
                                                _apellidoController.text,
                                                "Pago");
                                            await successDialog().then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          } else {
                                            repeatDialog();
                                          }
                                        });
                                      } else {
                                        errorDialog();
                                      }
                                    } else {
                                      errorDialog();
                                    }
                                    buttonActive = true;
                                  }
                                : null,
                            child: const Text("GUARDAR"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shadowColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: buttonActive
                                ? () {
                                    Navigator.of(context).pop();
                                  }
                                : null,
                            child: const Text("SALIR"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _selectedFile() async {
    FilePickerResult? fileresult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png']);
    if (fileresult != null &&
        (fileresult.files.first.name.toLowerCase().endsWith('.jpg') ||
            fileresult.files.first.name.toLowerCase().endsWith('.pdf') ||
            fileresult.files.first.name.toLowerCase().endsWith('.png'))) {
      setState(() {
        selectFilePayment = fileresult.files.first.bytes!;
        selectfile = fileresult.files.first.name;
      });
    } else {
      dialogo();
    }
  }

  _selectedImagePerfil() async {
    FilePickerResult? fileresult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (fileresult != null) {
      String? mimeType = mime(fileresult.files.first.name);
      if (mimeType != null && mimeType.startsWith('image/')) {
        setState(() {
          webImage = fileresult.files.first.bytes!;
          _pickedImage = fileresult.files.first.name;
        });
      } else {
        dialogo();
      }
    }
  }

  _selectedfileConstance() async {
    FilePickerResult? fileresult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    if (fileresult != null && fileresult.files.first.name.endsWith('pdf')) {
      setState(() {
        fileConstance = fileresult.files.first.bytes!;
        _filenameConstance = fileresult.files.first.name;
      });
    } else {
      dialogo();
    }
  }

  _selectedfileDNI() async {
    FilePickerResult? fileresult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (fileresult != null) {
      String? mimeType = mime(fileresult.files.first.name);
      if (mimeType != null && mimeType.startsWith('image/')) {
        setState(() {
          selectFileDNI = fileresult.files.first.bytes!;
          _filenameDNI = fileresult.files.first.name;
        });
      } else {
        dialogo();
      }
    }
  }

  Future<dynamic> dialogo() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child:
                              Text("LO SENTIMOS, NO SE ACEPTAN ESOS FORMATOS"),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cerrar"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  Future<dynamic> errorDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child:
                              Text("TIENES QUE COMPLETAR TODOS LOS FORMATOS"),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cerrar"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  Future<dynamic> repeatDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                              "YA SE ENCUENTRA UN REGISTRO CON EL MISMO DNI"),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cerrar"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  Future<dynamic> successDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("SE REGISTRÓ DE MANERA EXITOSA"),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("LISTO"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }
}
