import 'package:flutter/material.dart';

class CabeceraScreen extends StatefulWidget {
  const CabeceraScreen({
    super.key,
  });

  @override
  State<CabeceraScreen> createState() => _CabeceraScreenState();
}

class _CabeceraScreenState extends State<CabeceraScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, espacio) {
      return Stack(children: [
        Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final value = _controller.value;
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 80 * (1 - value)),
                      child: Image.asset(
                        "assets/logoConaeingeo.png",
                        fit: BoxFit.contain,
                        width: espacio.maxWidth,
                        height: 350,
                      ),
                    ),
                  );
                }),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          width: espacio.maxWidth,
          height: 200,
          alignment: Alignment.center,
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final value = _controller.value;
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 80 * (1 - value)),
                    child: Text(
                      "INSCRIPCIONES XIII CONAEINGEO UNC 2024 - UNC",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: espacio.maxWidth * 0.035,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ]);
    });
  }
}
