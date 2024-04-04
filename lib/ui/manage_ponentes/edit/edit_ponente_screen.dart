import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:mime_type/mime_type.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/ui/ponente/backend/ponente.dart';
import 'package:myapp/ui/ponente/backend/ponente_get_provider.dart';
import 'package:provider/provider.dart';

class EditPonenteScreen extends StatefulWidget {
  const EditPonenteScreen._({required this.ponentes});
  static Widget init({required Ponentes ponentes}) => ChangeNotifierProvider(
        create: (context) =>
            PonenteProvider(ponenteRepo: context.read<PonenteRepository>()),
        child: EditPonenteScreen._(
          ponentes: ponentes,
        ),
      );
  final Ponentes ponentes;
  @override
  State<EditPonenteScreen> createState() => _EditPonenteScreenState();
}

class _EditPonenteScreenState extends State<EditPonenteScreen> {
  final TextEditingController ponenteFullname = TextEditingController(text: "");
  final TextEditingController ponenteDescription =
      TextEditingController(text: "");
  final TextEditingController ponenteEspecialidad =
      TextEditingController(text: "");
  String ruta = "";

  Uint8List perfildataImage = Uint8List(8);
  @override
  void initState() {
    ruta = widget.ponentes.ruta;
    ponenteFullname.text = widget.ponentes.fullname;
    ponenteDescription.text = widget.ponentes.descripcion;
    ponenteEspecialidad.text = widget.ponentes.especialidad;
    super.initState();
  }

  bool network = true;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("EDITAR PONENTE"),
            backgroundColor: Colors.blue.shade300),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: ponenteFullname,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: ponenteDescription,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: ponenteEspecialidad,
            ),
          ),
          if (network)
            Stack(
              alignment: Alignment.center,
              children: [
                ImageNetwork(
                    onLoading: Image.asset(
                      'assets/logoConaeingeo.png',
                    ),
                    fullScreen: true,
                    debugPrint: true,
                    curve: Curves.bounceIn,
                    borderRadius: const BorderRadius.all(Radius.circular(360)),
                    image:
                        "http://localhost:8000/ponentes/${widget.ponentes.fullname}/${widget.ponentes.ruta}",
                    height: espacio.maxWidth > 1110
                        ? espacio.maxWidth * 0.17
                        : espacio.maxWidth > 700
                            ? espacio.maxWidth * 0.20
                            : espacio.maxWidth * 0.25,
                    width: espacio.maxWidth > 1110
                        ? espacio.maxWidth * 0.17
                        : espacio.maxWidth > 700
                            ? espacio.maxWidth * 0.20
                            : espacio.maxWidth * 0.25,
                    fitWeb: BoxFitWeb.fill),
                InkWell(
                  onTap: () async {
                    await _selectedImagePerfil()
                        .then((value) => value ? network = false : null);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: espacio.maxWidth > 1110
                        ? espacio.maxWidth * 0.17
                        : espacio.maxWidth > 700
                            ? espacio.maxWidth * 0.20
                            : espacio.maxWidth * 0.25,
                    width: espacio.maxWidth > 1110
                        ? espacio.maxWidth * 0.17
                        : espacio.maxWidth > 700
                            ? espacio.maxWidth * 0.20
                            : espacio.maxWidth * 0.25,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          if (network == false)
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              width: espacio.maxWidth > 700
                  ? espacio.maxWidth * 0.5
                  : espacio.maxWidth * 0.6,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  SizedBox(
                    width: espacio.maxWidth > 700
                        ? espacio.maxWidth * 0.5
                        : espacio.maxWidth * 0.6,
                    child: const Text.rich(
                      TextSpan(
                          text: "FOTO DE PERFIL",
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
                                text: "\nSolo se permiten formatos de imagen")
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ruta.isEmpty
                      ? const Icon(
                          Icons.edit_document,
                          size: 150,
                        )
                      : SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.memory(
                            perfildataImage,
                            fit: BoxFit.contain,
                          )),
                  TextButton.icon(
                    onPressed: () {
                      _selectedImagePerfil();
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text("MODALIDAD DE INSCRIPCIÓN"),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton.icon(
                onPressed: () {
                  context
                      .read<PonenteProvider>()
                      .edit(Ponentes(
                          id: widget.ponentes.id,
                          fullname: ponenteFullname.text,
                          especialidad: ponenteEspecialidad.text,
                          descripcion: ponenteDescription.text,
                          ruta: ruta))
                      .then((value) => uploadFiles(
                          perfildataImage, ruta, ponenteFullname.text));
                },
                icon: const Icon(Icons.save),
                label: const Text("GUARDAR")),
          ),
        ]),
      );
    });
  }

  Future<bool> _selectedImagePerfil() async {
    FilePickerResult? fileresult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (fileresult != null) {
      String? mimeType = mime(fileresult.files.first.name);
      if (mimeType != null && mimeType.startsWith('image/')) {
        setState(() {
          perfildataImage = fileresult.files.first.bytes!;
          ruta = fileresult.files.first.name;
        });
        return true;
      } else {
        dialogo();
        return false;
      }
    } else {
      return false;
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
}

uploadFiles(Uint8List file, String filename, String fullname) async {
  const String registerRef = 'http://127.0.0.1:8000/api/';
  http.MultipartFile multipartFile =
      http.MultipartFile.fromBytes('photo', file, filename: filename);
  try {
    final request =
        http.MultipartRequest('POST', Uri.parse("${registerRef}ponentePhoto"));
    request.files.add(multipartFile);
    request.fields['fullname'] = fullname;
    await request.send();
  } catch (e) {
    return e;
  }
}
