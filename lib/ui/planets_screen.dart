import 'package:flutter/material.dart';

import 'package:planets/app/app_config.dart';
import 'package:planets/entity/planet.dart';
import 'add_planet_screen.dart';
import 'components/rotation_planet.dart';

class PlanetsScreen extends StatefulWidget {
  const PlanetsScreen({super.key});

  @override
  State<PlanetsScreen> createState() => _PlanetsAppState();
}

class _PlanetsAppState extends State<PlanetsScreen> {
  List<Planet> planets = [];
  final appConfig = AppConfig.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50 * appConfig.coefficient,
              width: 50 * appConfig.coefficient,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.yellow,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: List.generate(
                planets.length,
                    (index) {
                  return RotationPlanet(
                    planet: planets[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Planet? newPlanet = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AddPlanetScreen(),
            ),
          );

          if (newPlanet != null) {
            planets.add(newPlanet);
            if (newPlanet.distance > appConfig.screenWeight) {
              appConfig.screenMax = newPlanet.distance;
            }
            appConfig.calcCoefficient();
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}