import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/repository/perfil/perfil_repository.dart';
import 'package:myapp/ui/perfil/backend/perfil.dart';

class PerfilFirebase implements PerfilReposiroty {
  final dio = Dio();
  final String registerRef = 'http://127.0.0.1:8000/api/';
  @override
  Future<Perfil> getPerfil() async {
    final bearerToken =
        await const FlutterSecureStorage().read(key: "BearerTokken");
    final response = await dio.post(
      "${registerRef}getPerfil",
      options: Options(
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      ),
    );
    final Map<String, dynamic> data = response.data;
    final perfil = Perfil.fromJson(data);

    return perfil;
  }

  @override
  Future<bool> addPerfil(Perfil perfil) {
    throw UnimplementedError();
  }

  /*final registerRef =
      FirebaseFirestore.instance.collection("perfil").withConverter<Perfil>(
          fromFirestore: (snapshots, _) {
            final perfil = Perfil.fromJson(snapshots.data()!);
            final newPerfil = perfil.copyWith(id: snapshots.id);
            return newPerfil;
          },
          toFirestore: (register, _) => register.toJson());*/
  // @override
  // Future<bool> addPerfil(Perfil perfil) async {
  //   var querySnapshot =
  //       await registerRef.where('dni', isEqualTo: perfil.dni).get();
  //   if (querySnapshot.docs.isEmpty) {
  //     await registerRef.add(perfil);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
