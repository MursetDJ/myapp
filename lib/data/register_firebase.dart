import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';

class RegisterFirebase implements RegisterRepository {
  final registerRef = FirebaseFirestore.instance
      .collection("registros")
      .withConverter<Register>(
          fromFirestore: (snapshots, _) {
            final register = Register.fromJson(snapshots.data()!);
            final newRegister = register.copyWith(id: snapshots.id);
            return newRegister;
          },
          toFirestore: (register, _) => register.toJson());
  @override
  Future<List<Register>> getRegistro() async {
    final querysnapshot = await registerRef.get();
    final registers = querysnapshot.docs.map((e) => e.data()).toList();
    return registers;
  }

  @override
  Future<bool> addRegister(Register register) async {
    var querySnapshot =
        await registerRef.where('dni', isEqualTo: register.dni).get();
    if (querySnapshot.docs.isEmpty) {
      await registerRef.add(register);
      return true;
    } else {
      return false;
    }
  }
}
