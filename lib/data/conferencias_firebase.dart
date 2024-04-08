import 'package:dio/dio.dart';
import 'package:myapp/repository/conferencia/conferencia_repository.dart';
import 'package:myapp/view/manage_asistencias/backend/conferencias.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConferenciaFirefase implements ConferenciaRepository {
  final shared = SharedPreferences.getInstance();
  final dio = Dio();
  final String poenenteRef = 'http://127.0.0.1:8000/api/';

  @override
  Future<bool> addConferencias(Conferencia conferencia) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}addConferencias",
        data: conferencia.toJson(),
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
  Future<List<Conferencia>> getConferencias() async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${poenenteRef}getConferencias",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
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
      final bearerToken = await shared;
      final result = await dio.post("${poenenteRef}editConferencias",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${bearerToken.getString('BearerTokken')}',
            },
          ),
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
      final bearerToken = await shared;
      final result = await dio.post("${poenenteRef}deleteConferencias",
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${bearerToken.getString('BearerTokken')}',
            },
          ),
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
