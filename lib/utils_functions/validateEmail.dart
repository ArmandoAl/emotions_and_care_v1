// ignore_for_file: file_names

bool validateEmail(String email) {
  //ejemplo de correos validos alvaradoarmando301@gmail.com,  alvarado.jose91@uabc.edu.mx, robarto.jose.guerrero12œuabc.edu.mx
  final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  return emailRegExp.hasMatch(email);
}

bool validatePhone(String phone) {
  final phoneRegExp = RegExp(r'^[0-9]{10}$');
  return phoneRegExp.hasMatch(phone);
}
