import 'package:dio/dio.dart';
import 'package:myapp/repository/salidas/salidas_repository.dart';
import 'package:myapp/view/salidas/backend/salidas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalidasFirebase implements SalidaRepository {
  final shared = SharedPreferences.getInstance();
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';

  @override
  Future<bool> addSalidas(Salidas salida) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}addSalidas",
        data: salida.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteSalida(Salidas salida) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}deleteSalidas",
        data: salida.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editSalida(Salidas salida) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}editSalidas",
        data: salida.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Salidas>> getSalidas(String? tipo) async {
    try {
      final bearerToken = await shared;

      final result = await dio.post(
        "${poenenteRef}getSalidas",
        data: {'tipo': tipo},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );

      final List<dynamic> data = result.data;
      final List<Salidas> salidasList =
          data.map((item) => Salidas.fromJson(item)).toList();
      return salidasList;
    } catch (e) {
      return [];
    }
  }
}
