class AppConfig {
  AppConfig._internal();

  static final AppConfig instance = AppConfig._internal();

  double screenWeight = 300;
  double maxWeight = 375;
  double coefficient = 1;

  void calcCoefficient() {
    coefficient = screenWeight / maxWeight;
  }

  set screenMax(double value) => maxWeight = value;
}