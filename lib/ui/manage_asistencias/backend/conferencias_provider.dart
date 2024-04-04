import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';

class ConferenciaProvider extends ChangeNotifier {
  ConferenciaProvider({required this.conferenciaRepo});
  final ConferenciaRepository conferenciaRepo;
  List<Conferencia>? conferencias;
  List<Conferencia>? conferenciOrderer;
  Future<void> get() async {
    conferencias = await conferenciaRepo.getConferencias();
    conferencias!
        .sort((a, b) => a.startConference.compareTo(b.startConference));

    notifyListeners();
  }

  Future<bool> edit(Conferencia conferencia) async {
    final result = await conferenciaRepo.editConferencia(conferencia);
    get();
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> add(Conferencia conferencia) async {
    final result = await conferenciaRepo.addConferencias(conferencia);
    notifyListeners();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
