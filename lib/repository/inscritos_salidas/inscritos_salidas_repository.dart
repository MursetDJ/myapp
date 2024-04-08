import 'package:myapp/view/salidas/backend/inscritos_salidas.dart';

abstract class InscritosSalidasRepository {
  Future<List<InscritosSalidas>> getInscritosSalidas();
  Future<List<InscritosSalidas>> getPersonalInscritosSalidas();

  Future<bool> addInscritosSalidas(InscritosSalidas inscritosSalidas);
  Future<bool> editInscritosSalidas(InscritosSalidas inscritosSalidas);
  Future<bool> deleteInscritosSalidas(InscritosSalidas inscritosSalidas);
}
