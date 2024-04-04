import 'package:flutter/material.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/ui/beneficios/backend/beneficios.dart';
import 'package:myapp/ui/beneficios/backend/beneficios_get_provider.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';
import 'package:myapp/ui/registrados/registrados.dart';
import 'package:provider/provider.dart';

class ManageBeneficios extends StatefulWidget {
  const ManageBeneficios._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) => BeneficiosProvider(
            beneficiosRepo: context.read<BeneficiosRepository>())
          ..get(),
        child: const ManageBeneficios._(),
      );

  @override
  @override
  State<ManageBeneficios> createState() => _ManageBeneficiosState();
}

class _ManageBeneficiosState extends State<ManageBeneficios> {
  int priority = 0;
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    final beneficios = context.watch<BeneficiosProvider>().beneficios;
    return LayoutBuilder(builder: (context, space) {
      return Scaffold(
        appBar: menuAppBar(space, context),
        body: beneficios == null
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
                                  beneficios
                                      .sort((a, b) => a.name.compareTo(b.name));
                                  if (ascending) {
                                    beneficios.sort(
                                        (a, b) => a.name.compareTo(b.name));
                                  } else {
                                    beneficios.sort(
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
                                  beneficios
                                      .sort((a, b) => a.tipo.compareTo(b.tipo));
                                  if (ascending) {
                                    beneficios.sort(
                                        (a, b) => a.tipo.compareTo(b.tipo));
                                  } else {
                                    beneficios.sort(
                                        (a, b) => b.tipo.compareTo(a.tipo));
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
                                  beneficios.sort((a, b) =>
                                      a.descripcion.compareTo(b.descripcion));
                                  if (ascending) {
                                    beneficios.sort((a, b) =>
                                        a.descripcion.compareTo(b.descripcion));
                                  } else {
                                    beneficios.sort((a, b) =>
                                        b.descripcion.compareTo(a.descripcion));
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
                          rows: beneficios
                              .map<DataRow>((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element.name)),
                                      DataCell(Text(element.tipo)),
                                      DataCell(Text(
                                        element.descripcion,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: IconButton(
                                              tooltip: "EDITAR",
                                              onPressed: () {
                                                Beneficios beneficio =
                                                    beneficios
                                                        .where((data) =>
                                                            data.id ==
                                                            element.id)
                                                        .first;

                                                Navigator.pushNamed(
                                                  context,
                                                  '/listbeneficios/edit',
                                                  arguments: (beneficio),
                                                ).whenComplete(() => context
                                                    .read<BeneficiosProvider>()
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
                                                final beneficio = context
                                                    .read<BeneficiosProvider>();
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
                                                                        beneficio
                                                                            .delete(
                                                                                element)
                                                                            .then((value) =>
                                                                                Navigator.of(context).pop());
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
              '/listbeneficios/add',
            ).whenComplete(() => context.read<BeneficiosProvider>().get());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
