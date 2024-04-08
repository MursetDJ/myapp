import 'package:myapp/view/salidas/backend/salidas.dart';

abstract class SalidaRepository {
  Future<List<Salidas>> getSalidas(String? tipo);
  Future<bool> addSalidas(Salidas salida);
  Future<bool> editSalida(Salidas salida);
  Future<bool> deleteSalida(Salidas salida);
}
