import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  bool? sesion;

  Future<String?> signInwithEmailAndPassword(
      String email, String password) async {
    final response = Dio();
    const url = "http://127.0.0.1:8000/api";
    try {
      final bearer = await response.post("$url/sessionGet",
          data: {"email": email, "password": password});
      return bearer.data;
    } catch (e) {
      return null;
    }
  }

  cerrarsesion(BuildContext context) {
    const FlutterSecureStorage().delete(key: "BearerTokken");
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  Future<bool> inSession() async =>
      const FlutterSecureStorage().read(key: "BearerTokken").then((value) {
        if (value != null) {
          return true;
        } else {
          return false;
        }
      });
}
