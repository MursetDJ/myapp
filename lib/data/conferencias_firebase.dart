import 'package:dio/dio.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/ui/manage_asistencias/backend/conferencias.dart';

class ConferenciaFirefase implements ConferenciaRepository {
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';

  @override
  Future<bool> addConferencias(Conferencia conferencia) async {
    try {
      final result = await dio.post("${poenenteRef}addConferencias",
          data: conferencia.toJson());
      bool response = result.data;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Conferencia>> getConferencias() async {
    try {
      final result = await dio.post(
        "${poenenteRef}getConferencias",
      );

      final List<dynamic> data = result.data;
      final List<Conferencia> conferenciaList =
          data.map((item) => Conferencia.fromJson(item)).toList();
      return conferenciaList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> editConferencia(Conferencia conferencia) async {
    try {
      final result = await dio.post("${poenenteRef}editConferencias",
          data: conferencia.toJson());
      bool response = result.data;

      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteConferencia(Conferencia conferencia) async {
    try {
      final result = await dio.post("${poenenteRef}deleteConferencias",
          data: conferencia.toJson());
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
