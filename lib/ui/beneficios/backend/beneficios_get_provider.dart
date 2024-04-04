import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/ui/beneficios/backend/beneficios.dart';

class BeneficiosProvider extends ChangeNotifier {
  BeneficiosProvider({required this.beneficiosRepo});
  final BeneficiosRepository beneficiosRepo;
  List<Beneficios>? beneficios;

  Future<void> get() async {
    beneficios = await beneficiosRepo.getBeneficios();
    notifyListeners();
  }

  Future<bool> edit(Beneficios beneficio) async {
    final result = await beneficiosRepo.editBeneficio(beneficio);

    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(Beneficios beneficio) async {
    final result = await beneficiosRepo.deleteBeneficio(beneficio);

    if (result) {
      beneficios?.remove(beneficio);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> add(Beneficios beneficio) async {
    final result = await beneficiosRepo.addBeneficio(beneficio);

    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
