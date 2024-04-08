import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/view/salidas/backend/salidas.dart';

class SalidasDiaScreen extends StatefulWidget {
  const SalidasDiaScreen({super.key, required this.salidas});
  final List<Salidas> salidas;
  @override
  State<SalidasDiaScreen> createState() => _DiaScreenState();
}

class _DiaScreenState extends State<SalidasDiaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Salidas>> conferenciafecha = {};

    final salidas = widget.salidas;
    for (Salidas conferencia in salidas) {
      String fecha = DateFormat('dd-MM-yyyy').format(conferencia.fecha);
      if (!conferenciafecha.containsKey(fecha)) {
        // Si la fecha no está en el mapa, agrega una nueva lista con la conferencia
        conferenciafecha[fecha] = [conferencia];
      } else {
        // Si la fecha ya está en el mapa, añade la conferencia a la lista existente
        conferenciafecha[fecha]!.add(conferencia);
      }
    }
    return ListView.builder(
      itemCount: conferenciafecha.keys.length,
      itemBuilder: (context, index) {
        String fecha = conferenciafecha.keys.elementAt(index);
        List<Salidas> conferenciasDeLafecha = conferenciafecha[fecha]!;

        return ListTile(
          title: Text('Día: $fecha'),
          subtitle: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                mainAxisExtent: 300),
            itemCount: conferenciasDeLafecha.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("HOLA ${salidas[index].lugar}"))
                ],
              ));
            },
          ),
        );
      },
    );
  }
}
