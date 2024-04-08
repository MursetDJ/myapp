import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/view/register/REGISTER/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFirebase implements RegisterRepository {
  final shared = SharedPreferences.getInstance();
  final dio = Dio();
  final String registerRef = 'http://127.0.0.1:8000/api/';

  /* final registerRef = FirebaseFirestore.instance
      .collection("registros")
      .withConverter<Register>(
          fromFirestore: (snapshots, _) {
            final register = Register.fromJson(snapshots.data()!);
            final newRegister = register.copyWith(id: snapshots.id);
            return newRegister;
          },
          toFirestore: (register, _) => register.toJson());*/
  @override
  Future<List<Register>> getRegistro() async {
    try {
      final bearerToken = await shared;
      final response = await dio.get(
        "${registerRef}getUsers",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
      );

      final List<dynamic> data = response.data;

      final List<Register> list =
          data.map((item) => Register.fromJson(item)).toList();

      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> addRegister(Register register) async {
    try {
      final bearerToken = await shared;
      final result = await dio.post(
        "${registerRef}createUser",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${bearerToken.getString('BearerTokken')}',
          },
        ),
        data: jsonEncode(register.toJson()),
      );
      return result.data;
    } catch (e) {
      return false;
    }
  }
}
