import 'package:myapp/ui/perfil/backend/perfil.dart';

abstract class PerfilReposiroty {
  Future<Perfil> getPerfil();
  Future<bool> addPerfil(Perfil perfil);
}
