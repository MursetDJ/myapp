import 'package:flutter/material.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/ui/asistencias/dia/dia_screen.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias_provider.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';
import 'package:myapp/ui/ponente/backend/ponente_get_provider.dart';
import 'package:provider/provider.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen._();
  static Widget init() => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ConferenciaProvider(
                conferenciaRepo: context.read<ConferenciaRepository>())
              ..get(),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                PonenteProvider(ponenteRepo: context.read<PonenteRepository>())
                  ..get(),
          ),
        ],
        child: const AsistenciaScreen._(),
      );
  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  int _selectedIndex = 0;

  List<DateTime> fechasUnicas = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ponentes = context.watch<PonenteProvider>().ponente;
    final conferencias = context.watch<ConferenciaProvider>().conferencias;
    return LayoutBuilder(builder: (context, space) {
      if (ponentes == null || conferencias == null) {
        return Scaffold(
          appBar: menuAppBar(space, context),
          body: const CircularProgressIndicator(),
        );
      } else {
        fechasUnicas = conferencias
            .map((p) {
              return DateTime(p.startConference.year, p.startConference.month,
                  p.startConference.day);
            })
            .toSet()
            .toList()
          ..sort();

        int diaIndex = 1;
        Map<String, List<Conferencia>> diaConferencia = {};

        for (DateTime fecha in fechasUnicas) {
          String dia = 'Día $diaIndex';
          diaConferencia[dia] = conferencias.where((conferencia) {
            if (conferencia.ponenteId == null) {
              return false;
            }
            return DateTime(
                        conferencia.startConference.year,
                        conferencia.startConference.month,
                        conferencia.startConference.day)
                    .compareTo(fecha) ==
                0;
          }).toList();
          diaIndex++;
        }

        return Scaffold(
          appBar: menuAppBar(space, context),
          body: IndexedStack(
            index: _selectedIndex,
            children: diaConferencia.entries.map((e) {
              if (e.key == "Día ${_selectedIndex + 1}") {
                return DiaScreen(ponentes: ponentes, conferencias: e.value);
              }

              return const SizedBox();
            }).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: diaConferencia.entries.map((e) {
              return BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_month), label: e.key);
            }).toList(),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        );
      }
    });
  }
}
