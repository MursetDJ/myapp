import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/view/ponente/backend/ponente.dart';

class PonenteProvider extends ChangeNotifier {
  PonenteProvider({required this.ponenteRepo});
  final PonenteRepository ponenteRepo;
  List<Ponentes>? ponente;

  Future<void> get() async {
    ponente = await ponenteRepo.getPonentes();
    notifyListeners();
  }

  Future<bool> edit(Ponentes ponentes) async {
    final result = await ponenteRepo.editPonente(ponentes);

    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(Ponentes ponentes) async {
    final result = await ponenteRepo.deletePonente(ponentes);

    if (result) {
      ponente?.remove(ponentes);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> add(Ponentes ponentes) async {
    final result = await ponenteRepo.addPonentes(ponentes);

    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
