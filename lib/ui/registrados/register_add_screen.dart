import 'package:flutter/material.dart';
import 'package:myapp/repository/register/register_repository.dart';
import 'package:myapp/ui/registrados/register_add_provider.dart';
import 'package:myapp/ui/registrados/register_list.dart';
import 'package:provider/provider.dart';

class RegisterAddDetails extends StatefulWidget {
  const RegisterAddDetails._();
  static Widget init() => ChangeNotifierProvider(
        create: (context) =>
            RegisterAddProvider(regRepo: context.read<RegisterRepository>()),
        child: const RegisterAddDetails._(),
      );
  @override
  State<RegisterAddDetails> createState() =>
      __RegisterDetailsScreenStateState();
}

class __RegisterDetailsScreenStateState extends State<RegisterAddDetails> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListProvider>();
    final registers = provider.registros;
    return Scaffold(
      appBar: AppBar(),
      body: registers == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return const ListTile();
              },
            ),
    );
  }
}
