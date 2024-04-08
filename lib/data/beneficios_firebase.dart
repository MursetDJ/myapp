import 'package:dio/dio.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/view/beneficios/backend/beneficios.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeneficiosFirebase implements BeneficiosRepository {
  final shared = SharedPreferences.getInstance();
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';
  @override
  Future<bool> addBeneficio(Beneficios beneficio) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}addBeneficios",
        data: beneficio.toJson(),
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
  Future<bool> deleteBeneficio(Beneficios beneficio) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}deleteBeneficios",
        data: beneficio.toJson(),
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
  Future<bool> editBeneficio(Beneficios beneficio) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}editBeneficios",
        data: beneficio.toJson(),
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
  Future<List<Beneficios>> getBeneficios() async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}getBeneficios",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );

      final List<dynamic> data = result.data;
      final List<Beneficios> conferenciaList =
          data.map((item) => Beneficios.fromJson(item)).toList();
      return conferenciaList;
    } catch (e) {
      return [];
    }
  }
}
