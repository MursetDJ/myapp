import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/ui/salidas/backend/salidas.dart';

class SalidasProvider extends ChangeNotifier {
  SalidasProvider({required this.salidasRepo});
  final SalidaRepository salidasRepo;
  List<Salidas>? salidas;
  List<Salidas>? salidasOrderer;
  Future<void> get(String? salida) async {
    salidas = await salidasRepo.getSalidas(salida);
    salidas!.sort((a, b) => a.fecha.compareTo(b.fecha));

    notifyListeners();
  }

  Future<bool> edit(Salidas salida) async {
    final result = await salidasRepo.editSalida(salida);
    get(null);
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> add(Salidas salida) async {
    final result = await salidasRepo.addSalidas(salida);
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(Salidas salida) async {
    final result = await salidasRepo.deleteSalida(salida);

    if (result) {
      salidas?.remove(salida);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
