import '../helpers/paths.dart';

Map<String, double> calculatePlantAndPotPosition(Size screenSize) {
  double width = screenSize.width;
  // Tamaño base
  double basePotSize = width * 0.25;
  double basePlantSize = width * 0.24;
  double basePotBottom = width * 0.45;
  double basePlantBottom = (basePotSize * 0.9) + basePotBottom + 10;

  // Ajustes para dispositivos muy pequeños (ej. iPhone Mini)
  if (width < 400) {
    basePotSize *= 0.8;
    basePlantSize *= 1;
    basePotBottom = width * 0.55;
    basePlantBottom = (basePotSize * 0.9) + basePotBottom;
  }

  // Ajustes para tablets (pantallas grandes)
  if (width > 700) {
    basePotSize *= 0.75;
    basePlantSize *= 0.75;
    basePotBottom = width * 0.25;
    basePlantBottom = (basePotSize) + basePotBottom;
  }

  return {
    "potSize": basePotSize,
    "plantSize": basePlantSize,
    "potBottom": basePotBottom,
    "plantBottom": basePlantBottom,
  };
}
