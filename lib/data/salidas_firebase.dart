import 'package:dio/dio.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/ui/salidas/backend/salidas.dart';

class SalidasFirebase implements SalidaRepository {
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';
  @override
  Future<bool> addSalidas(Salidas salida) async {
    try {
      print(salida.toJson());
      final result =
          await dio.post("${poenenteRef}addSalidas", data: salida.toJson());
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteSalida(Salidas salida) async {
    try {
      final result =
          await dio.post("${poenenteRef}deleteSalidas", data: salida.toJson());
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editSalida(Salidas salida) async {
    try {
      final result =
          await dio.post("${poenenteRef}editSalidas", data: salida.toJson());
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Salidas>> getSalidas(String? tipo) async {
    try {
      final result =
          await dio.post("${poenenteRef}getSalidas", data: {'tipo': tipo});

      final List<dynamic> data = result.data;
      final List<Salidas> salidasList =
          data.map((item) => Salidas.fromJson(item)).toList();
      return salidasList;
    } catch (e) {
      return [];
    }
  }
}
