import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarruselPlata extends StatefulWidget {
  const CarruselPlata({super.key});

  @override
  State<CarruselPlata> createState() => _CarruselPlataState();
}

class _CarruselPlataState extends State<CarruselPlata> {
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return CarouselSlider(
        carouselController: controller,
        options: CarouselOptions(
          height: 150,
          viewportFraction: 288 / espacio.maxWidth,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          'CIBER-GRUPO-HIERRO.png',
          'CODEa-UNI.png',
          'CRUZ-DE-MARIA.png',
          'GEOMINE.png',
          'GEOXPLORA.png',
          'NORTE-MINERO.png',
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 5)),
                child: Image.asset(
                  "assets/$i",
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }
}
