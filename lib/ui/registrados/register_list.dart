import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';

class ListProvider extends ChangeNotifier {
  ListProvider({required this.regRepo});
  final RegisterRepository regRepo;
  List<Register>? registros;
  List<Register>? searchRegister;
  List<Register>? searchUniversity;

  final Debouncer debouncer = Debouncer();
  Future<void> load() async {
    registros = await regRepo.getRegistro();
    _setinitialList();
    notifyListeners();
  }

  void _setinitialList() {
    searchRegister = List<Register>.from(registros ?? []);
  }

  void searchRegistros(String filter) async {
    debouncer.excecute(() {
      if (filter.isEmpty) {
        _setinitialList();
      } else {
        searchRegister = List<Register>.from(
          registros!.where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()) ||
              element.lastname.toLowerCase().contains(filter.toLowerCase()) ||
              element.university.toLowerCase().contains(filter.toLowerCase()) ||
              element.cicle.toLowerCase().contains(filter.toLowerCase()) ||
              element.hotmail.toLowerCase().contains(filter.toLowerCase()) ||
              element.modality.toLowerCase().contains(filter.toLowerCase())),
        );
      }
      notifyListeners();
    });
  }

  void searchUniversityRegistros(String filter) async {
    if (searchRegister == registros) {
    } else {}

    if (filter.isEmpty) {
      _setinitialList();
    } else {
      searchRegister = List<Register>.from(
        searchRegister!.where((element) =>
            element.university.toLowerCase().contains(filter.toLowerCase())),
      );
    }
    notifyListeners();
  }
}

class Debouncer {
  Timer? timer;
  void excecute(VoidCallback action) {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), action);
  }
}
