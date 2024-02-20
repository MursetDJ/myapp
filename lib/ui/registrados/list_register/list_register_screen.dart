import 'package:flutter/material.dart';
import 'package:myapp/ui/menu/menu_app_bar.dart';

class ListRegisterScreen extends StatefulWidget {
  const ListRegisterScreen({super.key});

  @override
  State<ListRegisterScreen> createState() => _ListRegisterScreenState();
}

class _ListRegisterScreenState extends State<ListRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Scaffold(
        appBar: menuAppBar(espacio),
      );
    });
  }
}
