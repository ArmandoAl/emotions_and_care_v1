import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotions&Care'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Text(aboutText,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  decoration: TextDecoration.none,
                )),
          ],
        ),
      ),
    );
  }
}

String aboutText = '''
Emotions&Care es una aplicación desarrollada por Tech4Good Research Lab, dirigida por la Dra. Karina Caro Corrales.

Equipo de Desarrollo
- Desarrollador Principal: José Armando Alvarado Loaiza
- Gerente de Proyecto: Pedro David Guevara Rodriguez
- Diseño de Interfaz: Martin Ortiz Gerardo, Diego Alberto Pimentel López
- Consultora de temas de salud mental: Sherlyn Haydee Hernández Chávez

- Analistas de Business Intelligence: Karen Lucía García Ramírez

Colaboradores
- Logo: Mayra Selene Aviña Morales
- Diseño: Martin Ortiz Gerardo
- Iconos: Diego Alberto Pimentel López

Agradecimientos Especiales a
- Brenda Janeth Ramirez Flores
- Xochitl Hernandez Gonzalez
- Arath Zahid Jesus Castro
''';
