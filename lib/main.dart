import 'package:flutter/material.dart';
import 'package:planets/ui/add_planet_screen.dart';
import 'package:planets/ui/components/rotation_planet.dart';

import 'app/app_config.dart';
import 'entity/planet.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlanetsApp(),
      ),
    );


class PlanetsApp extends StatefulWidget {
  const PlanetsApp({super.key});

  @override
  State<PlanetsApp> createState() => _PlanetsAppState();
}

class _PlanetsAppState extends State<PlanetsApp> {
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
              appConfig.max = newPlanet.distance;
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
