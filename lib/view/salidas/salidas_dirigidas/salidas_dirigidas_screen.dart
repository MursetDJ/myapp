import 'package:flutter/material.dart';
import 'package:myapp/repository/inscritos_salidas/inscritos_salidas_repository.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/view/menu/menu_app_bar.dart';
import 'package:myapp/view/salidas/backend/inscritos_salidas_provider.dart';
import 'package:myapp/view/salidas/backend/salidas.dart';
import 'package:myapp/view/salidas/backend/salidas_provider.dart';
import 'package:myapp/view/salidas/salidas_dirigidas/dia_salidas/dia_salidas_screen.dart';
import 'package:provider/provider.dart';

class SalidasScreen extends StatefulWidget {
  const SalidasScreen._();
  static Widget init() => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                SalidasProvider(salidasRepo: context.read<SalidaRepository>())
                  ..get(null),
          ),
          ChangeNotifierProvider(
            create: (context) => InscritosSalidasProvider(
                inscritosSalidasRepo:
                    context.read<InscritosSalidasRepository>())
              ..getPersonal(),
          ),
        ],
        child: const SalidasScreen._(),
      );
  @override
  State<SalidasScreen> createState() => _SalidasScreenState();
}

class _SalidasScreenState extends State<SalidasScreen> {
  int _selectedIndex = 0;

  List<DateTime> fechasUnicas = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final salidas2 = context.watch<SalidasProvider>().salidas;
    return LayoutBuilder(builder: (context, space) {
      if (salidas2 == null) {
        return Scaffold(
          appBar: menuAppBar(space, context),
          body: const CircularProgressIndicator(),
        );
      } else {
        final salidas =
            salidas2.where((element) => element.tipo == "dirigida").toList();
        fechasUnicas = salidas
            .map((p) {
              return DateTime(p.fecha.year, p.fecha.month, p.fecha.day);
            })
            .toSet()
            .toList()
          ..sort();

        int diaIndex = 1;
        Map<String, List<Salidas>> diaSalidas = {};

        for (DateTime fecha in fechasUnicas) {
          String dia = 'Día $diaIndex';
          diaSalidas[dia] = salidas.where((salidas) {
            return DateTime(salidas.fecha.year, salidas.fecha.month,
                        salidas.fecha.day)
                    .compareTo(fecha) ==
                0;
          }).toList();
          diaIndex++;
        }

        return Scaffold(
          appBar: menuAppBar(space, context),
          body: IndexedStack(
            index: _selectedIndex,
            children: diaSalidas.entries.map((e) {
              if (e.key == "Día ${_selectedIndex + 1}") {
                return SalidasDiaScreen(salidas: e.value);
              }

              return const SizedBox();
            }).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: diaSalidas.entries.map((e) {
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
