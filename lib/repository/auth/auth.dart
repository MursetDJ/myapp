import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final shared = SharedPreferences.getInstance();

  Future<String?> signInwithEmailAndPassword(
      String email, String password) async {
    final bearerToken = await shared;

    final response = Dio();
    const url = "http://127.0.0.1:8000/api";
    try {
      final bearer = await response.post("$url/sessionGet",
          data: {"email": email, "password": password});
      bearerToken.setString('BearerTokken', bearer.data[0]);
      bearerToken.setInt('User', bearer.data[1]);
      return "Existe";
    } catch (e) {
      return null;
    }
  }

  cerrarsesion(BuildContext context) async {
    final bearerToken = await shared;
    bearerToken.clear().then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (route) => false));
    const FlutterSecureStorage().delete(key: "BearerTokken");
  }

  Future<String?> inSession() async {
    final bearerToken = await shared;
    return bearerToken.getString('BearerTokken');
  }
}
