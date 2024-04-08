import 'package:dio/dio.dart';
import 'package:myapp/repository/inscritos_salidas/inscritos_salidas_repository.dart';
import 'package:myapp/view/salidas/backend/inscritos_salidas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscritosSalidasFirebase implements InscritosSalidasRepository {
  final shared = SharedPreferences.getInstance();
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';

  @override
  Future<bool> addInscritosSalidas(InscritosSalidas inscritosSalidas) {
    // TODO: implement addInscritosSalidas
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteInscritosSalidas(InscritosSalidas inscritosSalidas) {
    // TODO: implement deleteInscritosSalidas
    throw UnimplementedError();
  }

  @override
  Future<bool> editInscritosSalidas(InscritosSalidas inscritosSalidas) {
    // TODO: implement editInscritosSalidas
    throw UnimplementedError();
  }

  @override
  Future<List<InscritosSalidas>> getInscritosSalidas() {
    // TODO: implement getInscritosSalidas
    throw UnimplementedError();
  }

  @override
  Future<List<InscritosSalidas>> getPersonalInscritosSalidas() {
    // TODO: implement getPersonalInscritosSalidas
    throw UnimplementedError();
  }
}
