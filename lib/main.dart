import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/data/beneficios_firebase.dart';
import 'package:myapp/data/conferencias_firebase.dart';
import 'package:myapp/data/perfil_firebase.dart';
import 'package:myapp/data/ponente_firebase.dart';
import 'package:myapp/data/register_firebase.dart';
import 'package:myapp/data/salidas_firebase.dart';
import 'package:myapp/repository/auth/auth.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/repository/perfil/perfil_repository.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/test/carousel.dart';
import 'package:myapp/ui/asistencias/asistencias_screen.dart';
import 'package:myapp/ui/beneficios/backend/beneficios.dart';
import 'package:myapp/ui/beneficios/ui/add/add_beneficio_screen.dart';
import 'package:myapp/ui/beneficios/ui/beneficios_screen.dart';
import 'package:myapp/ui/beneficios/ui/edit/edit_beneficios_screen.dart';
import 'package:myapp/ui/beneficios/ui/manage_beneficios.dart';
import 'package:myapp/ui/buttonCard/button_style.dart';
import 'package:myapp/ui/manage_asistencias/add/add_manage_asistencias.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';
import 'package:myapp/ui/manage_asistencias/edit/edit_manage_asistencias.dart';
import 'package:myapp/ui/manage_asistencias/manage_asistencias_screen.dart';
import 'package:myapp/ui/manage_ponentes/add/add_ponente_screen.dart';
import 'package:myapp/ui/manage_ponentes/edit/edit_ponente_screen.dart';
import 'package:myapp/ui/manage_ponentes/manage_ponentes_screen.dart';
import 'package:myapp/ui/manage_salidas/add/add_salidas_screen.dart';
import 'package:myapp/ui/manage_salidas/edit/edit_salidas_screen.dart';
import 'package:myapp/ui/manage_salidas/manage_salidas_screen.dart';
import 'package:myapp/ui/menu/app_menu.dart';
import 'package:myapp/ui/menu/menu_screen.dart';
import 'package:myapp/ui/perfil/ui/perfil_screen.dart';
import 'package:myapp/ui/ponencias/ui/ponencias_screen.dart';
import 'package:myapp/ui/ponente/backend/ponente.dart';
import 'package:myapp/ui/ponente/ui/ponente_screen.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';
import 'package:myapp/ui/register/register_screen.dart';
import 'package:myapp/ui/registrados/options_register/edit_registrados.dart';
import 'package:myapp/ui/salidas/backend/salidas.dart';
import 'package:myapp/ui/salidas/salidas_dirigidas/salidas_dirigidas_screen.dart';
import 'package:myapp/ui/users/user_screen.dart';
import 'package:provider/provider.dart';

import 'ui/registrados/registrados.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await const FlutterSecureStorage().read(key: "BearerTokken");
  final initialRoute = storage != null ? '/menu' : '/login';
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<BeneficiosRepository>(create: (_) => BeneficiosFirebase()),
          Provider<RegisterRepository>(
            create: (_) => RegisterFirebase(),
          ),
          Provider<PonenteRepository>(
            create: (_) => PonenteFirefase(),
          ),
          Provider<PerfilReposiroty>(
            create: (_) => PerfilFirebase(),
          ),
          Provider<ConferenciaRepository>(
            create: (_) => ConferenciaFirefase(),
          ),
          Provider<SalidaRepository>(
            create: (_) => SalidasFirebase(),
          ),
        ],
        child: MaterialApp(
          //initialRoute: '/carousel',
          initialRoute: initialRoute,
          routes: {
            "/listsalidas": (context) => ManageSalidas.init(),
            '/listsalidas/add': (context) => AddSalidasScreen.init(),
            "/listsalidas/edit": (context) {
              final salidas =
                  ModalRoute.of(context)!.settings.arguments as Salidas;
              return EditSalidasScreen.init(salida: salidas);
            },
            "/salidasdirigidas": (context) => SalidasScreen.init(),
            "/ponentes": (context) => PonenteScreen.init(),
            "/listponentes/edit": (context) {
              final ponente =
                  ModalRoute.of(context)!.settings.arguments as Ponentes;
              return EditPonenteScreen.init(ponentes: ponente);
            },
            "/listbeneficios/edit": (context) {
              final beneficio =
                  ModalRoute.of(context)!.settings.arguments as Beneficios;
              return EditBeneficiosScreen.init(beneficio: beneficio);
            },
            '/listbeneficios/add': (context) => AddBeneficiosScreen.init(),
            "/listbeneficios": (context) => ManageBeneficios.init(),
            "/listponentes/add": (context) => AddPonenteScreen.init(),
            "/ponencias": (context) => const PonenciaScreen(),
            "/listponentes": (context) => ManagePonentes.init(),
            "/listconferencias": (context) => ManageAsistencias.init(),
            "/listconferencias/add": (context) => AddconferenciaScreen.init(),
            "/listconferencias/edit": (context) {
              final conferencia =
                  ModalRoute.of(context)!.settings.arguments as Conferencia;
              return EditConferenciaScreen.init(conferencias: conferencia);
            },
            '/beneficios': (context) => const BeneficiosScreen(),
            '/asistencia': (context) => AsistenciaScreen.init(),
            '/carousel': (context) => const MyAppcarousel(),
            '/perfil': (context) => PerfilScreen.init(),
            '/register': (context) => RegisterScreen.init(),
            '/login': (context) => const MyHomePage(title: "CONAEINGEO"),
            '/menu': (context) => const MenuScreen(),
            '/listregister': (context) => RegisterDetailsScreenState.init(),
            '/listregister/edit': (context) => EditRegistrado(
                registrado:
                    ModalRoute.of(context)!.settings.arguments as Register),
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _navigated = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_navigated && await Auth().inSession()) {
        _navigated = true;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/menu', (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          drawer: constraints.maxWidth < 700 ? const MenuWeb() : null,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            actions: constraints.maxWidth >= 700
                ? [
                    TextButton.icon(
                        style: designButton(),
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text("CONTACTOS")),
                    TextButton.icon(
                        style: designButton(),
                        onPressed: () {},
                        icon: const Icon(Icons.wallet),
                        label: const Text("PAGOS"))
                  ]
                : null,
            title: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                      blurRadius: 2, color: Colors.black, offset: Offset(0, 1))
                ],
              ),
            ),
          ),
          body: const UserScreen(),
        );
      },
    );
  }
}
