import 'package:flutter/material.dart';

import '../../../../config/assets/assets.dart';

class StartScreen extends StatefulWidget {
  final void Function() onTap;
  const StartScreen({super.key, required this.onTap});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    color: const Color(0xffFF7987).withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(100),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffFF7987),
                        blurRadius: 15,
                        spreadRadius: 10,
                      )
                    ]),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    color: const Color(0xffFF7987).withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(50),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffFF7987),
                        blurRadius: 15,
                        spreadRadius: 10,
                      )
                    ]),
              )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Text(
                          'Te damos la bienvenida a Emotions&Care',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.logo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text("¡Estamos aquí para apoyarte en cada paso del camino!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: widget.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Iniciar',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: const Color(0xff2CB5E0))),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
