import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';

class RegisterFirebase implements RegisterRepository {
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
  }
}
