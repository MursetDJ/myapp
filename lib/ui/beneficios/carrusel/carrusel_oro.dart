import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarruselOro extends StatefulWidget {
  const CarruselOro({super.key});

  @override
  State<CarruselOro> createState() => _CarruselOroState();
}

class _CarruselOroState extends State<CarruselOro>
    with TickerProviderStateMixin {
  final CarouselController controller = CarouselController();

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return MouseRegion(
        onHover: (value) {
          if (i == 0) {
            controller.stopAutoPlay();
            i++;
          }
          controller.stopAutoPlay();
        },
        onExit: (value) {
          if (i > 0) {
            i = 0;
          }
          controller.startAutoPlay();
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.yellowAccent.shade400),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
              height: 150,
              viewportFraction: 288 / espacio.maxWidth,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: false,
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
                  late final animationController = AnimationController(
                    vsync: this,
                    duration: const Duration(milliseconds: 200),
                    lowerBound: 0,
                    upperBound: 0.5,
                  );
                  late final scaleAnimation = Tween<double>(
                    begin: 1,
                    end: 1.2,
                  ).animate(animationController);

                  return MouseRegion(
                    onHover: (value) {
                      animationController.forward();
                    },
                    onExit: (value) {
                      animationController.reverse();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 215, 0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(width: 5)),
                      child: ScaleTransition(
                        scale: scaleAnimation,
                        child: Image.asset(
                          "assets/$i",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
