import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:mime_type/mime_type.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/ui/beneficios/backend/beneficios.dart';
import 'package:myapp/ui/beneficios/backend/beneficios_get_provider.dart';
import 'package:provider/provider.dart';

class EditBeneficiosScreen extends StatefulWidget {
  const EditBeneficiosScreen._({required this.beneficio});
  static Widget init({required Beneficios beneficio}) => ChangeNotifierProvider(
        create: (context) => BeneficiosProvider(
            beneficiosRepo: context.read<BeneficiosRepository>()),
        child: EditBeneficiosScreen._(
          beneficio: beneficio,
        ),
      );
  final Beneficios beneficio;
  @override
  State<EditBeneficiosScreen> createState() => _EditBeneficiosScreenState();
}

List<String> tipoBeneficio = ['ORO', 'PLATA', 'COBRE'];

class _EditBeneficiosScreenState extends State<EditBeneficiosScreen> {
  final TextEditingController beneficiosname = TextEditingController(text: "");
  final TextEditingController beneficiosDescription =
      TextEditingController(text: "");
  final TextEditingController beneficiosBeneficios =
      TextEditingController(text: "");
  final TextEditingController beneficiosUbicacion =
      TextEditingController(text: "");
  String _beneficiosImage = "";
  Uint8List beneficiosdataImage = Uint8List(8);
  String selectedTipo = "";
  bool network = true;
  @override
  void initState() {
    beneficiosBeneficios.text = widget.beneficio.beneficios;
    beneficiosDescription.text = widget.beneficio.descripcion;
    beneficiosUbicacion.text = widget.beneficio.ubicacion;
    beneficiosname.text = widget.beneficio.name;
    selectedTipo = widget.beneficio.tipo;
    _beneficiosImage = widget.beneficio.rutaImagen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("AGREGAR AUSPICIADOR"),
            backgroundColor: Colors.blue.shade300),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration:
                  const InputDecoration(label: Text("NOMBRE DEL AUSPICIADOR")),
              controller: beneficiosname,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(
                  label: Text("DESCRIPCIÓN DEL AUSPICIADOR")),
              controller: beneficiosDescription,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(
                  label: Text("BENEFICIOS DEL AUSPICIADOR")),
              controller: beneficiosBeneficios,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(
                  label: Text("UBICACIÓN DEL AUSPICIADOR")),
              controller: beneficiosUbicacion,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownButtonFormField(
                value: selectedTipo,
                hint: const Text("INGRESA EL TIPO DE AUSPICIADOR"),
                items: tipoBeneficio.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedTipo = value!;
                }),
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
                        "http://localhost:8000/documents/dwdw/beneficioshero-img.webp",
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
                    fitWeb: BoxFitWeb.scaleDown),
                InkWell(
                  onTap: () async {
                    await _selectedImagebeneficios()
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
                          text: "FOTO DE AUSPICIADOR",
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
                  _beneficiosImage.isEmpty
                      ? const Icon(
                          Icons.edit_document,
                          size: 150,
                        )
                      : SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.memory(
                            beneficiosdataImage,
                            fit: BoxFit.contain,
                          )),
                  TextButton.icon(
                    onPressed: () {
                      _selectedImagebeneficios();
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
                  context.read<BeneficiosProvider>().edit(Beneficios(
                      id: widget.beneficio.id,
                      tipo: selectedTipo,
                      rutaImagen: _beneficiosImage,
                      name: beneficiosname.text,
                      ubicacion: beneficiosUbicacion.text,
                      descripcion: beneficiosDescription.text,
                      beneficios: beneficiosBeneficios.text));
                },
                icon: const Icon(Icons.save),
                label: const Text("GUARDAR")),
          ),
        ]),
      );
    });
  }

  Future<bool> _selectedImagebeneficios() async {
    FilePickerResult? fileresult = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (fileresult != null) {
      String? mimeType = mime(fileresult.files.first.name);
      if (mimeType != null && mimeType.startsWith('image/')) {
        setState(() {
          beneficiosdataImage = fileresult.files.first.bytes!;
          _beneficiosImage = fileresult.files.first.name;
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

uploadFiles(Uint8List file, String filename) async {
  const String registerRef = 'http://127.0.0.1:8000/api/';
  http.MultipartFile multipartFile =
      http.MultipartFile.fromBytes('photo', file, filename: filename);
  try {
    final request =
        http.MultipartRequest('POST', Uri.parse("${registerRef}ponentePhoto"));
    request.files.add(multipartFile);
    request.fields['fullname'] = "fullname";
    await request.send();
  } catch (e) {
    return e;
  }
}
