import 'package:myapp/view/register/REGISTER/register.dart';

abstract class RegisterRepository {
  Future<List<Register>> getRegistro();
  Future<bool> addRegister(Register register);
}
