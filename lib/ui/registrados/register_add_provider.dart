import 'package:flutter/material.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/register/REGISTER/register.dart';

class RegisterAddProvider extends ChangeNotifier {
  RegisterAddProvider({required this.regRepo});
  final RegisterRepository regRepo;

  Future<bool> add(Register register) async {
    await regRepo.addRegister(register);
    return true;
  }
}
