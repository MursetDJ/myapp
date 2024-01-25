import 'package:flutter/material.dart';
import 'package:myapp/register/register_screen.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key, required this.context});
  final BuildContext context;
  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  bool? _button;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shadowColor: Colors.blue,
        content: StatefulBuilder(builder: (context, StateSetter setState) {
          return SizedBox(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "PARA REGISTRARSE PREVIAMENTE DEBEN HABER REALIZADO LOS SIGUIENTES PASOS:"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text('Haber realizado el pago al número #########'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text('Seleccionar de que universidad viene'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text('Agregar un correo al cual enviaremos'),
                  ),
                  CheckboxListTile(
                    title: const Text('HE LEIDO LOS PASOS A REALIZARCE'),
                    value: _button ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        _button = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("cancelar"),
                      ),
                      TextButton(
                        onPressed: _button != true
                            ? null
                            : () {
                                Navigator.of(context).pop();

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ));
                              },
                        child: const Text("INSCRIBIR"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
