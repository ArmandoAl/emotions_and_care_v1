class Api {
  // Instancia única de la clase Api
  static final Api _instance = Api._internal();

  // Constructor privado para evitar que se instancie la clase directamente
  Api._internal();

  // Método para obtener la instancia única de la clase Api
  factory Api() {
    return _instance;
  }

  // URL base de la API
  static const String baseUrl =
      'https://emotionsandcare-erffhse3f7aecnb0.eastus-01.azurewebsites.net/Api/';
}
