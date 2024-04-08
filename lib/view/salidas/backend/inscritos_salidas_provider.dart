import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/inscritos_salidas/inscritos_salidas_repository.dart';
import 'package:myapp/view/salidas/backend/inscritos_salidas.dart';

class InscritosSalidasProvider extends ChangeNotifier {
  InscritosSalidasProvider({required this.inscritosSalidasRepo});
  final InscritosSalidasRepository inscritosSalidasRepo;
  List<InscritosSalidas>? inscritosSalidas;
  List<InscritosSalidas>? salidasOrderer;
  Future<void> getPersonal() async {
    inscritosSalidas = await inscritosSalidasRepo.getPersonalInscritosSalidas();

    notifyListeners();
  }

  Future<bool> edit(InscritosSalidas inscritosSalida) async {
    final result =
        await inscritosSalidasRepo.editInscritosSalidas(inscritosSalida);
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> add(InscritosSalidas inscritosSalida) async {
    final result =
        await inscritosSalidasRepo.addInscritosSalidas(inscritosSalida);
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(InscritosSalidas inscritosSalida) async {
    final result =
        await inscritosSalidasRepo.deleteInscritosSalidas(inscritosSalida);

    if (result) {
      inscritosSalidas?.remove(inscritosSalida);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
