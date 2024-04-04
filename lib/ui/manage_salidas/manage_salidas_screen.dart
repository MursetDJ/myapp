import 'package:flutter/material.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';
import 'package:myapp/ui/registrados/registrados.dart';
import 'package:myapp/ui/salidas/backend/salidas.dart';
import 'package:myapp/ui/salidas/backend/salidas_provider.dart';
import 'package:provider/provider.dart';

class ManageSalidas extends StatefulWidget {
  const ManageSalidas._();
  static Widget init() => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) =>
                SalidasProvider(salidasRepo: context.read<SalidaRepository>())
                  ..get(null),
          ),
        ],
        child: const ManageSalidas._(),
      );

  @override
  State<ManageSalidas> createState() => _ManageSalidasState();
}

class _ManageSalidasState extends State<ManageSalidas> {
  int priority = 0;
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    final salidas = context.watch<SalidasProvider>().salidas;
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        appBar: menuAppBar(space, context),
        body: salidas == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: DataTable(
                          dataRowMinHeight: 40,
                          dataRowMaxHeight: space.maxWidth > 1100
                              ? 80
                              : 55000 / space.maxWidth,
                          sortColumnIndex: priority,
                          sortAscending: sort,
                          columns: <DataColumn>[
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 0;
                                  sort = !sort;
                                  ascending = sort;
                                  salidas.sort(
                                      (a, b) => a.lugar.compareTo(b.lugar));
                                  if (ascending) {
                                    salidas.sort(
                                        (a, b) => a.lugar.compareTo(b.lugar));
                                  } else {
                                    salidas.sort(
                                        (a, b) => b.lugar.compareTo(a.lugar));
                                  }
                                });
                              },
                              label: const Expanded(
                                  child: Text(
                                'LUGAR',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 1;
                                  sort = !sort;
                                  ascending = sort;
                                  salidas.sort(
                                      (a, b) => a.cupos.compareTo(b.cupos));
                                  if (ascending) {
                                    salidas.sort(
                                        (a, b) => a.cupos.compareTo(b.cupos));
                                  } else {
                                    salidas.sort(
                                        (a, b) => b.cupos.compareTo(a.cupos));
                                  }
                                });
                              },
                              label: const Expanded(
                                  child: Text(
                                'CUPOS',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 2;
                                  sort = !sort;
                                  ascending = sort;
                                  salidas.sort((a, b) => a.lugarDeSalida
                                      .compareTo(b.lugarDeSalida));
                                  if (ascending) {
                                    salidas.sort((a, b) => a.lugarDeSalida
                                        .compareTo(b.lugarDeSalida));
                                  } else {
                                    salidas.sort((a, b) => b.lugarDeSalida
                                        .compareTo(a.lugarDeSalida));
                                  }
                                });
                              },
                              label: const Expanded(
                                child: Text('LUGAR DE SALIDA',
                                    textAlign: TextAlign.center),
                              ),
                            ),

                            const DataColumn(
                              label: Expanded(
                                child: Text('OPCIONES',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            // Agrega más columnas según sea necesario
                          ],
                          rows: salidas
                              .map<DataRow>((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element.lugar)),
                                      DataCell(Text(element.cupos.toString())),
                                      DataCell(Text(element.lugarDeSalida)),
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: IconButton(
                                              tooltip: "EDITAR",
                                              onPressed: () {
                                                Salidas salida = salidas
                                                    .where((data) =>
                                                        data.id == element.id)
                                                    .first;

                                                Navigator.pushNamed(
                                                  context,
                                                  '/listsalidas/edit',
                                                  arguments: (salida),
                                                ).whenComplete(() => context
                                                    .read<SalidasProvider>()
                                                    .get(null));
                                              },
                                              icon: const Icon(Icons.edit),
                                              style: designIconButtonTable(
                                                  Colors.white, Colors.blue),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: IconButton(
                                              tooltip: "ELIMINAR",
                                              onPressed: () {
                                                final salida = context
                                                    .read<SalidasProvider>();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Colors.red,
                                                              Colors.black
                                                            ]),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                      width: space.maxWidth >
                                                              700
                                                          ? space.maxWidth * 0.6
                                                          : space.maxWidth *
                                                              0.9,
                                                      height: 300,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(30),
                                                              child: Text(
                                                                "¿ESTÁS SEGURO DE ELIMINAR LA SALIDA?",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      30.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  TextButton(
                                                                      style: const ButtonStyle(
                                                                          backgroundColor: MaterialStatePropertyAll(Colors
                                                                              .green),
                                                                          foregroundColor: MaterialStatePropertyAll(Colors
                                                                              .white)),
                                                                      onPressed:
                                                                          () async {
                                                                        salida
                                                                            .delete(element)
                                                                            .then((value) {
                                                                          print(
                                                                              value);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        });
                                                                      },
                                                                      child: const Text(
                                                                          "SI, ESTOY SEGURO")),
                                                                  TextButton(
                                                                      style: const ButtonStyle(
                                                                          backgroundColor: MaterialStatePropertyAll(Colors
                                                                              .red),
                                                                          foregroundColor: MaterialStatePropertyAll(Colors
                                                                              .white)),
                                                                      onPressed:
                                                                          () async {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: const Text(
                                                                          "NO, NO QUIERO BORRAR")),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.delete),
                                              style: designIconButtonTable(
                                                  Colors.white, Colors.red),
                                            ),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade400,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/listsalidas/add',
            ).whenComplete(() => context.read<SalidasProvider>().get(null));
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
