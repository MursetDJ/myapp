import 'package:flutter/material.dart';
import 'package:myapp/repository/perfil/perfil_repository.dart';
import 'package:myapp/ui/perfil/backend/perfil.dart';

class PerfilAddProvider extends ChangeNotifier {
  PerfilAddProvider({required this.refPerfil});
  final PerfilReposiroty refPerfil;

  Future<bool> add(Perfil perfil) async {
    await refPerfil.addPerfil(perfil);
    return true;
  }
}
