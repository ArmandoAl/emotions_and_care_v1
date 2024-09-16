import 'package:flutter/material.dart';

class HomeController extends StatefulWidget {
  final int idUser;
  final Function changeIndex;
  const HomeController(
      {super.key, required this.idUser, required this.changeIndex});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  late bool isIOS;

  @override
  void initState() {
    super.initState();
    isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: isIOS ? null : const Drawer(),
        body: const Center(
          child: Text('Hello World'),
        ),
        bottomNavigationBar: isIOS
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'School',
                  ),
                ],
              )
            : null);
  }
}
