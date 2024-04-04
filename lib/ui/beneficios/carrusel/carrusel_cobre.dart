import 'package:flutter/material.dart';

List<String> sponsors = [
  'CIBER-GRUPO-HIERRO.png',
  'CODEa-UNI.png',
  'CRUZ-DE-MARIA.png',
  'GEOMINE.png',
  'GEOXPLORA.png',
  'NORTE-MINERO.png',
];

class CarruselCobre extends StatelessWidget {
  const CarruselCobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (var i = 0; i < sponsors.length; i++)
          Container(
            margin: const EdgeInsets.all(8),
            height: 120,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.yellow.shade800,
              borderRadius: const BorderRadius.all(Radius.circular(45)),
              border: Border.all(width: 1, color: Colors.blue),
            ),
            child: Image.asset(
              "assets/${sponsors[i]}",
              fit: BoxFit.fill,
            ),
          ),
      ],
    );
  }
}
