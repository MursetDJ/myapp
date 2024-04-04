import 'package:dio/dio.dart';
import 'package:myapp/repository/ponente/ponente_repository.dart';
import 'package:myapp/ui/ponente/backend/ponente.dart';

class PonenteFirefase implements PonenteRepository {
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';

  @override
  Future<bool> addPonentes(Ponentes ponente) async {
    try {
      final result =
          await dio.post("${poenenteRef}addPonentes", data: ponente.toJson());
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Ponentes>> getPonentes() async {
    try {
      final result = await dio.post(
        "${poenenteRef}getPonentes",
      );
      final List<dynamic> data = result.data;
      final List<Ponentes> ponenteList =
          data.map((item) => Ponentes.fromJson(item)).toList();
      return ponenteList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> editPonente(Ponentes ponente) async {
    try {
      final result =
          await dio.post("${poenenteRef}editPonentes", data: ponente.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deletePonente(Ponentes ponente) async {
    try {
      final result = await dio.post("${poenenteRef}deletePonentes",
          data: ponente.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  /* final registerRef = FirebaseFirestore.instance
      .collection("registros")
      .withConverter<Register>(
          fromFirestore: (snapshots, _) {
            final register = Register.fromJson(snapshots.data()!);
            final newRegister = register.copyWith(id: snapshots.id);
            return newRegister;
          },
          toFirestore: (register, _) => register.toJson());*/
  /*@override
  Future<List<Register>> getRegistro() async {
    final response = await dio.get("${registerRef}getUsers");

    final List<dynamic> data = response.data;

    final List<Register> list =
        data.map((item) => Register.fromJson(item)).toList();

    return list;
  }

  @override
  Future<bool> addRegister(Register register) async {
    try {
      final result = await dio.post(
        "${registerRef}createUser",
        data: jsonEncode(register.toJson()),
      );
      return result.data;
    } catch (e) {
      return false;
    }
  }*/
}
