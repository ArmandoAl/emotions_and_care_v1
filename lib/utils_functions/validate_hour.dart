bool validateHour(String hour) {
  final RegExp regExp = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
  return !regExp.hasMatch(hour);
}
