import 'package:dio/dio.dart';
import 'package:myapp/repository/beneficios/beneficios_repository.dart';
import 'package:myapp/ui/beneficios/backend/beneficios.dart';

class BeneficiosFirebase implements BeneficiosRepository {
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';
  @override
  Future<bool> addBeneficio(Beneficios beneficio) async {
    try {
      final result = await dio.post("${poenenteRef}addBeneficios",
          data: beneficio.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteBeneficio(Beneficios beneficio) async {
    try {
      print(beneficio.toJson());
      final result = await dio.post("${poenenteRef}deleteBeneficios",
          data: beneficio.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editBeneficio(Beneficios beneficio) async {
    try {
      final result = await dio.post("${poenenteRef}editBeneficios",
          data: beneficio.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Beneficios>> getBeneficios() async {
    try {
      final result = await dio.post(
        "${poenenteRef}getBeneficios",
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
