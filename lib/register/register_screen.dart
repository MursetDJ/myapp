import 'package:flutter/material.dart';
import 'package:myapp/register/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context,espacio) {
          return Column(
            children: [
              CabeceraScreen(),
               SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: espacio.maxWidth * 0.5,
                child: TextField(
                  
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

