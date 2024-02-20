import 'package:flutter/material.dart';
import 'package:myapp/ui/register/register_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "PARA REGISTRARSE PREVIAMENTE DEBEN HABER REALIZADO LOS SIGUIENTES PASOS:"),
                ),
                ListTile(
                  leading: const Icon(Icons.circle, size: 8),
                  title: GestureDetector(
                    onTap: () {
                      sendWhatsAppMessage('901167572',
                          'Hola, he realizado el pago, Me gustaría saber cuales son los siguientes pasos.');
                    },
                    child: const Text(
                      'HABER REALIZADO EL PAGO AL NÚMERO 976 228 062',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.circle, size: 8),
                  title: Text('LLENA LOS DATOS DE LOS FORMULARIOS'),
                ),
                const ListTile(
                  leading: Icon(Icons.circle, size: 8),
                  title: Text(
                      'AGREGA UN CORREO AL CUAL ENVIAREMOS LOS DETALLES DE TU USUARIO'),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("cancelar"),
                    ),
                    TextButton(
                      onPressed: _button != true
                          ? null
                          : () {
                              Navigator.of(context).pop();

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterScreen.init(),
                              ));
                            },
                      child: const Text("INSCRIBIR"),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}

void sendWhatsAppMessage(String phoneNumber, String message) async {
  Uri whatsappUrl =
      Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}");
  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl);
  } else {}
}
