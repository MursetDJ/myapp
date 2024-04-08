import 'package:flutter/material.dart';
import 'package:myapp/view/register/REGISTER/register.dart';

class EditRegistrado extends StatefulWidget {
  const EditRegistrado({Key? key, required this.registrado}) : super(key: key);
  final Register registrado;
  @override
  State<EditRegistrado> createState() => _EditRegistradoState();
}

class _EditRegistradoState extends State<EditRegistrado> {
  // final _nameController = TextEditingController();
  // final _lastnameController = TextEditingController();
  // final _dniController = TextEditingController();
  // final _correoController = TextEditingController();
  bool edit = false;
  Register? registro;
  @override
  void initState() {
    registro = widget.registrado;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
