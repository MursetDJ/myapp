import 'package:flutter/material.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/view/manage_asistencias/backend/conferencias.dart';
import 'package:myapp/view/manage_asistencias/backend/conferencias_provider.dart';
import 'package:myapp/view/menu/menu_app_bar.dart';
import 'package:myapp/view/ponente/backend/ponente_get_provider.dart';
import 'package:myapp/view/registrados/registrados.dart';
import 'package:provider/provider.dart';

class ManageAsistencias extends StatefulWidget {
  const ManageAsistencias._();
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
        child: const ManageAsistencias._(),
      );

  @override
  State<ManageAsistencias> createState() => _ManageAsistenciasState();
}

class _ManageAsistenciasState extends State<ManageAsistencias> {
  int priority = 0;
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    final ponentes = context.watch<PonenteProvider>().ponente;
    final conferencias = context.watch<ConferenciaProvider>().conferencias;
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        appBar: menuAppBar(space, context),
        body: conferencias == null
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
                                  conferencias
                                      .sort((a, b) => a.name.compareTo(b.name));
                                  if (ascending) {
                                    conferencias.sort(
                                        (a, b) => a.name.compareTo(b.name));
                                  } else {
                                    conferencias.sort(
                                        (a, b) => b.name.compareTo(a.name));
                                  }
                                });
                              },
                              label: const Expanded(
                                  child: Text(
                                'NOMBRE',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  priority = 1;
                                  sort = !sort;
                                  ascending = sort;
                                  conferencias.sort(
                                      (a, b) => a.lugar.compareTo(b.lugar));
                                  if (ascending) {
                                    conferencias.sort(
                                        (a, b) => a.lugar.compareTo(b.lugar));
                                  } else {
                                    conferencias.sort(
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
                                  priority = 2;
                                  sort = !sort;
                                  ascending = sort;
                                  conferencias.sort((a, b) =>
                                      a.description.compareTo(b.description));
                                  if (ascending) {
                                    conferencias.sort((a, b) =>
                                        a.description.compareTo(b.description));
                                  } else {
                                    conferencias.sort((a, b) =>
                                        b.description.compareTo(a.description));
                                  }
                                });
                              },
                              label: const Expanded(
                                child: Text('DESCRIPCIÓN',
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
                          rows: conferencias
                              .map<DataRow>((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element.name)),
                                      DataCell(Text(element.lugar)),
                                      DataCell(Text(element.description)),
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (element.ponenteId != null)
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: IconButton(
                                                tooltip: "QUITAR PONENTE",
                                                onPressed: () {
                                                  element = element.copyWith(
                                                      ponenteId: null);
                                                  context
                                                      .read<
                                                          ConferenciaProvider>()
                                                      .edit(element);
                                                },
                                                icon: const Icon(
                                                    Icons.person_off_rounded),
                                                style: designIconButtonTable(
                                                    Colors.white, Colors.red),
                                              ),
                                            ),
                                          if (element.ponenteId == null)
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: IconButton(
                                                tooltip: "ASIGNAR PONENTE",
                                                onPressed: () {
                                                  int? opcionseleccionada;
                                                  final conferenciaProvider =
                                                      context.read<
                                                          ConferenciaProvider>();
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Center(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                                  colors: [
                                                                Colors.red,
                                                                Colors.black
                                                              ]),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                        width: space.maxWidth >
                                                                700
                                                            ? space.maxWidth *
                                                                0.6
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
                                                                        .all(
                                                                            30),
                                                                child: Text(
                                                                  "¿QUÉ PONENTE QUIERES ASIGNARLE?",
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
                                                              Material(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    0,
                                                                    255,
                                                                    193,
                                                                    7),
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                child: Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            16.0),
                                                                    child:
                                                                        InputDecorator(
                                                                      decoration:
                                                                          const InputDecoration(
                                                                              border: OutlineInputBorder()),
                                                                      child: DropdownButtonFormField(
                                                                          dropdownColor: const Color.fromARGB(0, 255, 193, 7),
                                                                          style: const TextStyle(color: Colors.white),
                                                                          hint: const Text("ESCOJA UN PONENTE", style: TextStyle(color: Colors.white)),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                          items: ponentes?.map((ponente) {
                                                                            return DropdownMenuItem<int>(
                                                                              value: ponente.id,
                                                                              child: Text(ponente.fullname),
                                                                            );
                                                                          }).toList(),
                                                                          onChanged: (int? value) {
                                                                            opcionseleccionada =
                                                                                value!;
                                                                          }),
                                                                    ),
                                                                  ),
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
                                                                          final elementconferencia =
                                                                              element.copyWith(ponenteId: opcionseleccionada);

                                                                          conferenciaProvider
                                                                              .edit(elementconferencia);
                                                                          Navigator.of(context)
                                                                              .pop();
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
                                                                            "NO, CANCELAR")),
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
                                                icon: const Icon(
                                                    Icons.person_add),
                                                style: designIconButtonTable(
                                                    Colors.white,
                                                    Colors.green.shade700),
                                              ),
                                            ),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: IconButton(
                                              tooltip: "EDITAR",
                                              onPressed: () {
                                                Conferencia conferencia =
                                                    conferencias
                                                        .where((data) =>
                                                            data.id ==
                                                            element.id)
                                                        .first;

                                                Navigator.pushNamed(
                                                  context,
                                                  '/listconferencias/edit',
                                                  arguments: (conferencia),
                                                ).whenComplete(() => context
                                                    .read<ConferenciaProvider>()
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
                                                final conferencias =
                                                    context.read<
                                                        ConferenciaProvider>();
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
                                                                          () async {
                                                                        Navigator.of(context)
                                                                            .pop();
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
              '/listconferencias/add',
            ).whenComplete(() => context.read<ConferenciaProvider>().get());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
