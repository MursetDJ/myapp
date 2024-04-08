import 'package:myapp/view/ponente/backend/ponente.dart';

abstract class PonenteRepository {
  Future<List<Ponentes>> getPonentes();
  Future<bool> addPonentes(Ponentes perfil);
  Future<bool> editPonente(Ponentes perfil);
  Future<bool> deletePonente(Ponentes perfil);
}
