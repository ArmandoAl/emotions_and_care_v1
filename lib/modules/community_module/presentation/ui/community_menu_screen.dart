import 'package:flutter/material.dart';
import '../../../../config/assets/assets.dart';

class CommunityMenuScreen extends StatefulWidget {
  final void Function() onCartsTap;
  final void Function() onPostsTap;
  final void Function() onCartFromUserTap;
  const CommunityMenuScreen(
      {super.key,
      required this.onCartsTap,
      required this.onPostsTap,
      required this.onCartFromUserTap});

  @override
  State<CommunityMenuScreen> createState() => _CommunityMenuScreenState();
}

class _CommunityMenuScreenState extends State<CommunityMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: GestureDetector(
                onTap: widget.onCartsTap,
                child: Stack(children: [
                  Image.asset(
                    Assets.menuCarta,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ]),
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.065),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              child: GestureDetector(
                onTap: () async {
                  await showCommingSoonDialog(context);
                },
                child: Image.asset(
                  Assets.menuPost,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              )),
        ],
      ),
    );
  }
}

Future<void> showCommingSoonDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Próximamente'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'Esta funcionalidad estará disponible en futuras actualizaciones.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
