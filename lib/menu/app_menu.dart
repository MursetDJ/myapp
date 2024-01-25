import 'package:flutter/material.dart';

class MenuWeb extends StatelessWidget {
  const MenuWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromARGB(106, 33, 149, 243),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Image.asset(
                  "assets/logoConaeingeo.png",
                  width: 60,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}
