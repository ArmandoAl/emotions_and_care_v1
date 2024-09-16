import 'package:flutter/material.dart';

import '../../../../config/assets/assets.dart';

class BegginScreen extends StatefulWidget {
  final void Function() onLogin;
  final void Function() onRegister;
  const BegginScreen(
      {super.key, required this.onLogin, required this.onRegister});

  @override
  State<BegginScreen> createState() => _BegginScreenState();
}

class _BegginScreenState extends State<BegginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff1C8AAD),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 88, 165),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(500),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(
              Assets.logo,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Positioned(
              bottom: -MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                    color: Color(0xffFF7987),
                    borderRadius: BorderRadius.all(Radius.circular(500))),
              )),
          Positioned(
              bottom: -MediaQuery.of(context).size.height * 0.06,
              right: -MediaQuery.of(context).size.width * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                    color: Color(0xffFF7987),
                    borderRadius: BorderRadius.all(Radius.circular(500))),
              )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ElevatedButton(
                  onPressed: widget.onRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF3A953),
                    elevation: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Text('Registrarse',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            color: Colors.white)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ElevatedButton(
                  onPressed: widget.onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text('Iniciar sesión',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
