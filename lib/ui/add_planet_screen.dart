import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'package:planets/entity/planet.dart';

class AddPlanetScreen extends StatefulWidget {
  const AddPlanetScreen({super.key});

  @override
  State<AddPlanetScreen> createState() => _AddPlanetScreenState();
}

class _AddPlanetScreenState extends State<AddPlanetScreen> {
  GlobalKey<FormState> key = GlobalKey();
  late TextEditingController controllerDistance;
  late double rotationSpeed;
  late double radius;
  late Color selectedColor;

  @override
  void initState() {
    selectedColor = Colors.blue;
    radius = 10;
    controllerDistance = TextEditingController();
    rotationSpeed = 1.0;
    super.initState();
  }

  @override
  void dispose() {
    controllerDistance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Параметры планеты"),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await ColorPicker(
                    color: selectedColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ).showPickerDialog(
                    context,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: selectedColor,
                  ),
                  child: const Text("Выбрать цвет"),
                ),
              ),
              const SizedBox(height: 30),
              Slider(
                value: radius,
                min: 5,
                max: 50.0, // Adjust the maximum speed as needed
                onChanged: (value) {
                  setState(() {
                    radius = value;
                  });
                },
              ),
              Text('Радиус: ${radius.toStringAsFixed(1)}'),
              const SizedBox(height: 16),
              TextFormField(
                validator: _distanceValidator,
                keyboardType: TextInputType.number,
                controller: controllerDistance,
                decoration: const InputDecoration(
                  labelText: "Удаленность",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: rotationSpeed,
                min: 0.1,
                max: 10.0, // Adjust the maximum speed as needed
                onChanged: (value) {
                  setState(() {
                    rotationSpeed = value;
                  });
                },
              ),
              Text('Скорость: ${rotationSpeed.toStringAsFixed(1)} об/с'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (key.currentState?.validate() == true) {
            Navigator.pop(
                context,
                Planet(
                  radius: radius,
                  color: selectedColor,
                  distance: double.parse(controllerDistance.text),
                  speed: rotationSpeed,
                ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String? _distanceValidator(String? value) {
    if (value?.isEmpty == true) {
      return "Обязательное поле";
    } else if (int.tryParse(value ?? "") == null) {
      return "Введите целое число";
    } else if (int.tryParse(value ?? "-1")! < 0) {
      return "Введите положительное число";
    }
    return null;
  }
}
