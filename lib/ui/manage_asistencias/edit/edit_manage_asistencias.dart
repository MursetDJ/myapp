import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias_provider.dart';
import 'package:provider/provider.dart';

class EditConferenciaScreen extends StatefulWidget {
  const EditConferenciaScreen._({required this.conferencias});
  static Widget init({required Conferencia conferencias}) =>
      ChangeNotifierProvider(
        create: (context) => ConferenciaProvider(
            conferenciaRepo: context.read<ConferenciaRepository>()),
        child: EditConferenciaScreen._(
          conferencias: conferencias,
        ),
      );
  final Conferencia conferencias;
  @override
  State<EditConferenciaScreen> createState() => _EditConferenciaScreenState();
}

class _EditConferenciaScreenState extends State<EditConferenciaScreen> {
  final TextEditingController conferencianame = TextEditingController(text: "");
  final TextEditingController conferenciaLugar =
      TextEditingController(text: "");
  final TextEditingController conferenciaDescripcion =
      TextEditingController(text: "");
  late DateTime fechainicio;
  late DateTime fechafin;
  late TimeOfDay horainicio;
  late TimeOfDay horafin;
  Uint8List perfildataImage = Uint8List(8);
  @override
  void initState() {
    horainicio = TimeOfDay(
        hour: widget.conferencias.startConference.hour,
        minute: widget.conferencias.startConference.minute);
    horafin = TimeOfDay(
        hour: widget.conferencias.endConference.hour,
        minute: widget.conferencias.endConference.minute);
    fechainicio = widget.conferencias.startConference;
    fechafin = widget.conferencias.endConference;
    conferencianame.text = widget.conferencias.name;
    conferenciaLugar.text = widget.conferencias.lugar;
    conferenciaDescripcion.text = widget.conferencias.description;
    super.initState();
  }

  bool network = true;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("EDITAR CONFERENCIA"),
            backgroundColor: Colors.blue.shade300),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: conferencianame,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: conferenciaLugar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: conferenciaDescripcion,
              ),
            ),
            Text(
              'FECHA INICIO: ${DateFormat("dd-MM-yyyy").format(fechainicio)} A LAS ${horainicio.hour.toString().padLeft(2, "0")}:${horainicio.minute.toString().padLeft(2, "0")}',
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
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
                        initialDate: fechainicio,
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
                        if (fechaSeleccionada.difference(fechafin).inDays > 0) {
                          fechafin = fechaSeleccionada;
                        }
                        setState(() {
                          fechainicio = fechaSeleccionada;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    onPressed: () async {
                      final horaSeleccionada = await showTimePicker(
                        helpText: "INGRESA TIEMPO",
                        confirmText: "ACEPTAR",
                        cancelText: "CANCELAR",
                        hourLabelText: "HORA",
                        minuteLabelText: "MINUTO",
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        context: context,
                        initialTime: TimeOfDay(
                            hour: widget.conferencias.startConference.hour,
                            minute: widget.conferencias.startConference.minute),
                      );
                      if (horaSeleccionada != null) {
                        setState(() {
                          horainicio = horaSeleccionada;
                        });
                      }
                    },
                    child: const Text(
                      'Seleccionar hora',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Text(
              'FECHA FINAL: ${DateFormat("dd-MM-yyyy").format(fechafin)} A LAS ${horafin.hour.toString().padLeft(2, "0")}:${horafin.minute.toString().padLeft(2, "0")}',
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
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
                        initialDate: fechafin,
                        confirmText: "CONFIRMAR",
                        cancelText: "CANCELAR",
                        helpText: "SELECCIONA",
                        errorInvalidText: "NO ESTÁ EN EL RANGO",
                        errorFormatText: "EL FORMATO ESTÁ MAL ES MES/DIA/AÑO",
                        fieldHintText: "INGRESA LA FECHA DE INICIO",
                        fieldLabelText: "FECHA",
                        context: context,
                        firstDate: fechainicio,
                        lastDate: DateTime(2025),
                      );
                      if (fechaSeleccionada != null) {
                        setState(() {
                          fechafin = fechaSeleccionada;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    onPressed: () async {
                      final horaSeleccionada = await showTimePicker(
                        helpText: "INGRESA TIEMPO",
                        confirmText: "ACEPTAR",
                        cancelText: "CANCELAR",
                        hourLabelText: "HORA",
                        minuteLabelText: "MINUTO",
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        context: context,
                        initialTime: TimeOfDay(
                            hour: widget.conferencias.endConference.hour,
                            minute: widget.conferencias.endConference.minute),
                      );
                      if (horaSeleccionada != null) {
                        setState(() {
                          horafin = horaSeleccionada;
                        });
                      }
                    },
                    child: const Text(
                      'Seleccionar hora',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  onPressed: () {
                    context.read<ConferenciaProvider>().edit(Conferencia(
                          id: widget.conferencias.id,
                          name: conferencianame.text,
                          lugar: conferenciaLugar.text,
                          description: conferenciaDescripcion.text,
                          startConference: DateTime(
                              fechainicio.year,
                              fechainicio.month,
                              fechainicio.day,
                              horainicio.hour,
                              horainicio.minute),
                          endConference: DateTime(fechafin.year, fechafin.month,
                              fechafin.day, horafin.hour, horafin.minute),
                        ));
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "GUARDAR",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ]),
        ),
      );
    });
  }
}
