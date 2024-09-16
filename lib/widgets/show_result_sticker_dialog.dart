import 'package:provider/provider.dart';

import '../config/assets/assets.dart';
import '../helpers/paths.dart';

Future<void> showStikerDialog(BuildContext context, UserProvider userProvider) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    'Gracias por contestar nuestro cuestionario. Tenemos un pequeño regalo para ti.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('¡Nuevo sticker desbloqueado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const Image(
                image: AssetImage(Assets.cat),
                fit: BoxFit.cover,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1C8AAD),
                ),
                onPressed: () async {
                  if (userProvider.registerPatientFlow ==
                      RegisterPatientFlow.registerSucess) {
                    userProvider.setRegisterFlow(
                        RegisterPatientFlow.firstTestCompleted);
                  }

                  final uiProvider =
                      Provider.of<UIProvider>(context, listen: false);
                  uiProvider.addSticker(StickerModel(
                    id: 2,
                    url: Assets.cat,
                  ));

                  if (context.mounted) Navigator.of(context).pop();
                },
                child: const Text('Recoger sticker',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
