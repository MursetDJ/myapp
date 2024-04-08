import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/view/salidas/backend/salidas.dart';
import 'package:myapp/view/salidas/backend/salidas_provider.dart';
import 'package:provider/provider.dart';

class AddSalidasScreen extends StatefulWidget {
  const AddSalidasScreen._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            SalidasProvider(salidasRepo: context.read<SalidaRepository>()),
        child: const AddSalidasScreen._(),
      );

  @override
  State<AddSalidasScreen> createState() => _AddSalidasScreenState();
}

List<String> tipoSalida = ['dirigida', 'práctica'];

class _AddSalidasScreenState extends State<AddSalidasScreen> {
  DateTime fecha = DateTime(2024);
  String selectedTipo = "";
  final TextEditingController salidaLugar = TextEditingController(text: "");
  final TextEditingController salidaCupos = TextEditingController(text: "");
  final TextEditingController salidaPrecios = TextEditingController(text: "");
  final TextEditingController salidaLugarSalida =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("AGREGAR SALIDA A CAMPO"),
            backgroundColor: Colors.blue.shade300),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration:
                  const InputDecoration(label: Text("LUGAR DE LA SALIDA")),
              controller: salidaLugar,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: const InputDecoration(
                  label: Text("LUGAR DE SALIDA DE LA SALIDA")),
              controller: salidaLugarSalida,
            ),
          ),
          Text(
            'FECHA DE SALIDA (Día-Mes-Año): ${DateFormat("dd-MM-yyyy").format(fecha)} ',
            style: const TextStyle(fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: const Text(
                    'Seleccionar fecha',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final fechaSeleccionada = await showDatePicker(
                      initialEntryMode: DatePickerEntryMode.inputOnly,
                      initialDate: fecha,
                      confirmText: "CONFIRMAR",
                      cancelText: "CANCELAR",
                      helpText: "SELECCIONA",
                      errorInvalidText: "NO ESTÁ EN EL RANGO",
                      errorFormatText: "EL FORMATO ESTÁ MAL ES MES/DIA/AÑO",
                      fieldHintText: "INGRESA LA FECHA DE INICIO",
                      fieldLabelText: "FECHA",
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (fechaSeleccionada != null) {
                      setState(() {
                        fecha = fechaSeleccionada;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration:
                  const InputDecoration(label: Text("CUPOS DE LA SALIDA")),
              controller: salidaCupos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(
                  label: Text("PRECIO DE LA SALIDA (Individual)")),
              controller: salidaPrecios,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownButtonFormField(
                hint: const Text("INGRESA EL TIPO DE AUSPICIADOR"),
                items: tipoSalida.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedTipo = value!;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton.icon(
                onPressed: () {
                  context.read<SalidasProvider>().add(Salidas(
                      fecha: fecha,
                      lugarDeSalida: salidaLugarSalida.text,
                      lugar: salidaLugar.text,
                      tipo: selectedTipo,
                      cupos: int.parse(salidaCupos.text),
                      precio: double.parse(salidaPrecios.text)));
                },
                icon: const Icon(Icons.save),
                label: const Text("GUARDAR")),
          ),
        ]),
      );
    });
  }
}
