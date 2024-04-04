import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyAppcarousel extends StatefulWidget {
  const MyAppcarousel({super.key});

  @override
  State<MyAppcarousel> createState() => _MyAppcarouselState();
}

class _MyAppcarouselState extends State<MyAppcarousel> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Carrusel Infinito')),
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 300,
              viewportFraction: 0.2,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 5),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return MouseRegion(
                    onHover: (value) {
                      setState(() {});
                    },
                    onExit: (value) {
                      setState(() {});
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Text(
                          'text $i',
                          style: const TextStyle(fontSize: 16.0),
                        )),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
