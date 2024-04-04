import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/ui/design/bodydesign/design_body_colors.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';
import 'package:myapp/ui/ponente/backend/ponente_get_provider.dart';
import 'package:provider/provider.dart';

class PonenteScreen extends StatefulWidget {
  const PonenteScreen._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            PonenteProvider(ponenteRepo: context.read<PonenteRepository>())
              ..get(),
        child: const PonenteScreen._(),
      );

  @override
  State<PonenteScreen> createState() => _PonenteScreenState();
}

class _PonenteScreenState extends State<PonenteScreen> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<PonenteProvider>().ponente;
    switch (data) {
      case null:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case []:
        return const Center(
          child: Text(
              "NO SE HA ENCONTRADO NINGÚN PONENTE, EN CASO DE SER UN ERROR CARGUE DE NUEVO LA PÁGINA",
              style: TextStyle(
                color: Colors.red,
                fontSize: 50,
              )),
        );
      default:
    }

    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: menuAppBar(espacio, context),
        body: DecoratedBox(
          decoration: decoracionFondo(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: espacio.maxWidth > 1110
                    ? 450
                    : espacio.maxWidth > 700
                        ? 423
                        : 330,
                crossAxisCount: espacio.maxWidth > 1110
                    ? 5
                    : espacio.maxWidth > 700
                        ? 4
                        : 2,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 194, 71, 18),
                        Color.fromARGB(255, 120, 5, 5)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageNetwork(
                            onLoading: Image.asset(
                              'assets/logoConaeingeo.png',
                            ),
                            fullScreen: true,
                            debugPrint: true,
                            curve: Curves.bounceIn,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(360)),
                            image:
                                "http://localhost:8000/ponentes/${data[index].fullname}/${data[index].ruta}",
                            height: espacio.maxWidth > 1110
                                ? espacio.maxWidth * 0.17
                                : espacio.maxWidth > 700
                                    ? espacio.maxWidth * 0.20
                                    : espacio.maxWidth * 0.25,
                            width: espacio.maxWidth > 1110
                                ? espacio.maxWidth * 0.17
                                : espacio.maxWidth > 700
                                    ? espacio.maxWidth * 0.20
                                    : espacio.maxWidth * 0.25,
                            fitWeb: BoxFitWeb.scaleDown),
                      ),
                      datos(espacio, "NOMBRE: ", data[index].fullname,
                          Icons.person_4_rounded),
                      datos(espacio, "ESPECIALIDAD: ", data[index].especialidad,
                          Icons.class_),
                      datos(espacio, "DESCRIPCIÓN: ", data[index].descripcion,
                          Icons.folder_special),
                      const Padding(padding: EdgeInsets.all(10))
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

TextStyle estilosGrid(BoxConstraints espacio) {
  return TextStyle(
      fontSize: espacio.maxWidth > 1110
          ? 14
          : espacio.maxWidth > 700
              ? 13
              : 12,
      decoration: TextDecoration.none,
      color: Colors.white);
}

Padding datos(BoxConstraints espacio, String typedata, String name,
    IconData iconorepresentativo) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Stack(
      children: [
        Icon(
          size: 20,
          iconorepresentativo,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text.rich(TextSpan(
              style: estilosGrid(espacio),
              text: typedata,
              children: [
                TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ])),
        ),
      ],
    ),
  );
}
