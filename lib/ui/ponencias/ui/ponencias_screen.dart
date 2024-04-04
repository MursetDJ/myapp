import 'package:flutter/material.dart';

class PonenciaScreen extends StatefulWidget {
  const PonenciaScreen({super.key});

  @override
  State<PonenciaScreen> createState() => _PonenciaScreenState();
}

class _PonenciaScreenState extends State<PonenciaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 16 / 18,
                  crossAxisCount: 3,
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.black,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
