import 'package:flutter/material.dart';

import 'package:planets/entity/planet.dart';
import 'package:planets/app/app_config.dart';

class RotationPlanet extends StatefulWidget {
  final Planet planet;

  const RotationPlanet({
    super.key,
    required this.planet,
  });

  @override
  State<RotationPlanet> createState() => _RotationPlanetState();
}

class _RotationPlanetState extends State<RotationPlanet>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    controller.repeat(
      min: 0.0,
      max: 1.0,
      period: Duration(seconds: (1 / widget.planet.speed).ceil()),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig.instance;

    double sizeBox = widget.planet.distance * appConfig.coefficient +
        50 * appConfig.coefficient +
        widget.planet.radius * 2 * appConfig.coefficient;
    return SizedBox(
      height: sizeBox,
      width: sizeBox,
      child: RotationTransition(
        turns: controller,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: widget.planet.color,
            ),
            height: widget.planet.radius * appConfig.coefficient,
            width: widget.planet.radius * appConfig.coefficient,
          ),
        ),
      ),
    );
  }
}