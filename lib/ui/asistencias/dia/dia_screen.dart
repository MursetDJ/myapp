import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';
import 'package:myapp/ui/ponente/backend/ponente.dart';

class DiaScreen extends StatefulWidget {
  const DiaScreen(
      {super.key, required this.ponentes, required this.conferencias});
  final List<Ponentes> ponentes;
  final List<Conferencia> conferencias;
  @override
  State<DiaScreen> createState() => _DiaScreenState();
}

class _DiaScreenState extends State<DiaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Conferencia>> conferenciaHora = {};

    final conferencias = widget.conferencias;
    final ponentes = widget.ponentes;
    for (Conferencia conferencia in conferencias) {
      String hora = DateFormat('HH:mm:ss').format(conferencia.startConference);
      if (!conferenciaHora.containsKey(hora)) {
        // Si la hora no está en el mapa, agrega una nueva lista con la conferencia
        conferenciaHora[hora] = [conferencia];
      } else {
        // Si la hora ya está en el mapa, añade la conferencia a la lista existente
        conferenciaHora[hora]!.add(conferencia);
      }
    }
    return ListView.builder(
      itemCount: conferenciaHora.keys.length,
      itemBuilder: (context, index) {
        String hora = conferenciaHora.keys.elementAt(index);
        List<Conferencia> conferenciasDeLaHora = conferenciaHora[hora]!;

        return ListTile(
          title: Text('Hora: $hora'),
          subtitle: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                mainAxisExtent: 300),
            itemCount: conferenciasDeLaHora.length,
            itemBuilder: (context, index) {
              final ponente = ponentes
                  .where((e) => e.id == conferenciasDeLaHora[index].ponenteId)
                  .first;
              print(ponente.ruta);
              return Card(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageNetwork(
                      image:
                          "http://localhost:8000/ponentes/${ponente.fullname}/${ponente.ruta}",
                      height: 150,
                      width: 150,
                      fullScreen: true,
                    ),
                  )
                ],
              ));
            },
          ),
        );
      },
    );
  }
}
