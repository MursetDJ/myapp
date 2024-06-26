import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/view/menu/menu_app_bar.dart';
import 'package:myapp/view/register/REGISTER/register.dart';
import 'package:myapp/view/registrados/register_list.dart';
import 'package:provider/provider.dart';

List<Map<bool, String>> universities = [
  {true: "UNIVERSIDAD NACIONAL DE SAN ANTONIO ABAD DEL CUSCO"},
  {true: "UNIVERSIDAD NACIONAL DANIEL ALCIDES CARRIÓN"},
  {true: "UNIVERSIDAD NACIONAL DE CAJAMARCA"},
  {true: "UNIVERSIDAD NACIONAL DE INGENIERÍA"},
  {true: "UNIVERSIDAD NACIONAL DE PIURA"},
  {true: "UNIVERSIDAD NACIONAL DE SAN AGUSTIN DE AREQUIPA"},
  {true: "UNIVERSIDAD NACIONAL DEL ALTIPLANO PUNO"},
  {true: "UNIVERSIDAD NACIONAL MAYOR DE SAN MARCOS"},
  {true: "UNIVERSIDAD PRIVADA DEL NORTE"},
  {true: "PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ"},
  {true: "UNIVERSIDAD NACIONAL JORGE BASADRE GROHMANN"},
];

class RegisterDetailsScreenState extends StatefulWidget {
  const RegisterDetailsScreenState._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            ListProvider(regRepo: context.read<RegisterRepository>())..load(),
        child: const RegisterDetailsScreenState._(),
      );
  @override
  State<RegisterDetailsScreenState> createState() =>
      __RegisterDetailsScreenStateState();
}

class __RegisterDetailsScreenStateState
    extends State<RegisterDetailsScreenState> {
  final ScrollController _scrollController = ScrollController();
  bool sort = true;
  int priority = 0;
  int valor = -1;
  String search = "";
  @override
  Widget build(BuildContext context) {
    final registers = context.watch<ListProvider>().searchRegister;

    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: menuAppBar(espacio, context),
        body: registers == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: espacio.maxWidth * 0.6,
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        search = value;
                        valor = universities.indexWhere(
                            (element) => element.keys.first == false);
                        context.read<ListProvider>().searchRegistros(
                            value,
                            valor >= 0 ? true : false,
                            valor >= 0 ? universities[valor].values.first : "");
                      },
                      decoration: const InputDecoration(
                        label: Text(
                          "BÚSQUEDA",
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: espacio.maxWidth * 0.6,
                    height: 40,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        _scrollController.jumpTo(
                            _scrollController.offset - details.delta.dx);
                      },
                      child: CustomScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextButton(
                                      style: universities[index].keys.first
                                          ? const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black))
                                          : const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey)),
                                      onPressed: () {
                                        valor = universities.indexWhere(
                                            (element) =>
                                                element.keys.first == false);
                                        if (valor >= 0 && valor != index) {
                                          universities[valor] = {
                                            true:
                                                universities[valor].values.first
                                          };
                                        }

                                        universities[index] = {
                                          !universities[index].keys.first:
                                              universities[index].values.first
                                        };
                                        valor = universities.indexWhere(
                                            (element) =>
                                                element.keys.first == false);
                                        context
                                            .read<ListProvider>()
                                            .searchRegistros(
                                                search,
                                                valor >= 0 ? true : false,
                                                valor >= 0
                                                    ? universities[valor]
                                                        .values
                                                        .first
                                                    : "");
                                        setState(() {});
                                      },
                                      child: Text(
                                        universities[index].values.first,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                        textAlign: TextAlign.center,
                                      )),
                                );
                              },
                              childCount: universities.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(50.0),
                      child: CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                          child: DataTable(
                            dataRowMinHeight: 20,
                            dataRowMaxHeight: 100,
                            sortColumnIndex: priority,
                            sortAscending: sort,
                            columns: <DataColumn>[
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    priority = 0;
                                    sort = !sort;
                                    ascending = sort;
                                    registers.sort(
                                        (a, b) => a.name.compareTo(b.name));
                                    if (ascending) {
                                      registers.sort(
                                          (a, b) => a.name.compareTo(b.name));
                                    } else {
                                      registers.sort(
                                          (a, b) => b.name.compareTo(a.name));
                                    }
                                  });
                                },
                                label: const Expanded(
                                    child: Text(
                                  'Nombre',
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    priority = 1;
                                    sort = !sort;
                                    ascending = sort;
                                    registers.sort((a, b) =>
                                        a.lastname.compareTo(b.lastname));
                                    if (ascending) {
                                      registers.sort((a, b) =>
                                          a.lastname.compareTo(b.lastname));
                                    } else {
                                      registers.sort((a, b) =>
                                          b.lastname.compareTo(a.lastname));
                                    }
                                  });
                                },
                                label: const Expanded(
                                    child: Text(
                                  'Apellidos',
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    priority = 2;
                                    sort = !sort;
                                    ascending = sort;
                                    registers
                                        .sort((a, b) => a.dni.compareTo(b.dni));
                                    if (ascending) {
                                      registers.sort(
                                          (a, b) => a.dni.compareTo(b.dni));
                                    } else {
                                      registers.sort(
                                          (a, b) => b.dni.compareTo(a.dni));
                                    }
                                  });
                                },
                                label: const Expanded(
                                    child: Text(
                                  'DNI',
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    priority = 3;
                                    sort = !sort;
                                    ascending = sort;
                                    registers.sort((a, b) =>
                                        a.university.compareTo(b.university));
                                    if (ascending) {
                                      registers.sort((a, b) =>
                                          a.university.compareTo(b.university));
                                    } else {
                                      registers.sort((a, b) =>
                                          b.university.compareTo(a.university));
                                    }
                                  });
                                },
                                label: const Expanded(
                                  child: Text('Universidad',
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    priority = 4;
                                    sort = !sort;
                                    ascending = sort;
                                    registers.sort((a, b) =>
                                        a.inscription.compareTo(b.inscription));
                                    if (ascending) {
                                      registers.sort((a, b) => a.inscription
                                          .compareTo(b.inscription));
                                    } else {
                                      registers.sort((a, b) => b.inscription
                                          .compareTo(a.inscription));
                                    }
                                  });
                                },
                                label: const Expanded(
                                  child: Text('Inscripciones',
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
                            rows: registers
                                .map<DataRow>((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(element.name)),
                                        DataCell(Text(element.lastname)),
                                        DataCell(Text(element.dni)),
                                        DataCell(Text(element.university)),
                                        DataCell(Text(element.inscription)),
                                        DataCell(Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: IconButton(
                                                tooltip: "EDITAR",
                                                onPressed: () {
                                                  Register registrados =
                                                      registers
                                                          .where((data) =>
                                                              data.dni ==
                                                              element.dni)
                                                          .first;

                                                  Navigator.pushNamed(
                                                    context,
                                                    '/listregister/edit',
                                                    arguments: registrados,
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                                style: designIconButtonTable(
                                                    Colors.white, Colors.blue),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: IconButton(
                                                tooltip: "VER",
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .remove_red_eye_rounded),
                                                style: designIconButtonTable(
                                                    Colors.white, Colors.green),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(8),
                                              child: IconButton(
                                                tooltip: "ELIMINAR",
                                                onPressed: () {},
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
                      ]),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}

ButtonStyle designIconButtonTable(
    Color iconColor, Color backgroundButtonColor) {
  return ButtonStyle(
      iconColor: MaterialStatePropertyAll(iconColor),
      backgroundColor: MaterialStatePropertyAll(backgroundButtonColor));
}
/*ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: registers.length,
                itemBuilder: (BuildContext context, int index) {
                  if (registers.isNotEmpty) {
                    final element = registers[index];
                    return Row(
                      children: [
                        Text("${element.name} ${element.lastname}"),
                      ],
                    );
                  }

                  return null;
                },
              ),*/