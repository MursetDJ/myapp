import 'package:flutter/material.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/view/menu/menu_app_bar.dart';
import 'package:myapp/view/ponente/backend/ponente.dart';
import 'package:myapp/view/ponente/backend/ponente_get_provider.dart';
import 'package:myapp/view/registrados/registrados.dart';
import 'package:provider/provider.dart';

class ManagePonentes extends StatefulWidget {
  const ManagePonentes._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            PonenteProvider(ponenteRepo: context.read<PonenteRepository>())
              ..get(),
        child: const ManagePonentes._(),
      );

  @override
  State<ManagePonentes> createState() => _ManagePonentesState();
}

class _ManagePonentesState extends State<ManagePonentes> {
  int priority = 0;
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    final ponentes = context.watch<PonenteProvider>().ponente;
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        appBar: menuAppBar(space, context),
        body: ponentes == null
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
                                  ponentes.sort((a, b) =>
                                      a.fullname.compareTo(b.fullname));
                                  if (ascending) {
                                    ponentes.sort((a, b) =>
                                        a.fullname.compareTo(b.fullname));
                                  } else {
                                    ponentes.sort((a, b) =>
                                        b.fullname.compareTo(a.fullname));
                                  }
                                });
                              },
                              label: const Expanded(
                                  child: Text(
                                'NOMBRE COMPLETO',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 1;
                                  sort = !sort;
                                  ascending = sort;
                                  ponentes.sort((a, b) =>
                                      a.descripcion.compareTo(b.descripcion));
                                  if (ascending) {
                                    ponentes.sort((a, b) =>
                                        a.descripcion.compareTo(b.descripcion));
                                  } else {
                                    ponentes.sort((a, b) =>
                                        b.descripcion.compareTo(a.descripcion));
                                  }
                                });
                              },
                              label: const Expanded(
                                  child: Text(
                                'DESCRIPCIÓN',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 2;
                                  sort = !sort;
                                  ascending = sort;
                                  ponentes.sort((a, b) =>
                                      a.especialidad.compareTo(b.especialidad));
                                  if (ascending) {
                                    ponentes.sort((a, b) => a.especialidad
                                        .compareTo(b.especialidad));
                                  } else {
                                    ponentes.sort((a, b) => b.especialidad
                                        .compareTo(a.especialidad));
                                  }
                                });
                              },
                              label: const Expanded(
                                child: Text('ESPECIALIDAD',
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
                          rows: ponentes
                              .map<DataRow>((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element.fullname)),
                                      DataCell(Text(element.descripcion)),
                                      DataCell(Text(element.especialidad)),
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: IconButton(
                                              tooltip: "EDITAR",
                                              onPressed: () {
                                                Ponentes ponente = ponentes
                                                    .where((data) =>
                                                        data.id == element.id)
                                                    .first;

                                                Navigator.pushNamed(
                                                  context,
                                                  '/listponentes/edit',
                                                  arguments: (ponente),
                                                ).whenComplete(() => context
                                                    .read<PonenteProvider>()
                                                    .get());
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
                                                final ponenteProvider = context
                                                    .read<PonenteProvider>();
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
                                                                "¿ESTÁS SEGURO DE ELIMINAR EL PONENTE?",
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
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        ponenteProvider
                                                                            .delete(element);
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
                                                                          () {
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
              '/listponentes/add',
            ).whenComplete(() => context.read<PonenteProvider>().get());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
