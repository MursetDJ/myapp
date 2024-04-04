import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/perfil/perfil_repository.dart';
import 'package:myapp/ui/perfil/backend/perfil.dart';

class PerfilProvider extends ChangeNotifier {
  PerfilProvider({required this.perfilRepo});
  final PerfilReposiroty perfilRepo;
  Perfil? perfil;

  Future<void> get() async {
    perfil = await perfilRepo.getPerfil();

    notifyListeners();
  }
}
