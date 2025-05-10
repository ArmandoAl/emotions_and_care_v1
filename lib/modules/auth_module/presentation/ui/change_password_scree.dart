import 'package:emotions_and_care_v1/helpers/paths.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  final Future<bool> Function(String) changePassword;
  const ChangePasswordScreen(
      {super.key, required this.email, required this.changePassword});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: 'Cambiar contraseña',
        isForReturn: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Agrega tu nueva contraseña',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Nueva contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: controller2,
                  decoration: const InputDecoration(
                    labelText: 'Repite la nueva contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (controller.text.isEmpty || controller2.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Por favor, ingresa una nueva contraseña'),
                      ),
                    );
                    return;
                  }

                  if (controller.text != controller2.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                      ),
                    );
                    return;
                  }

                  bool? res;

                  await showLoadingdialog("Cargando datos", context, () async {
                    res = await widget.changePassword(controller.text);
                  });

                  if (res == true && context.mounted) {
                    if (context.mounted) {
                      await showLoadingdialog(
                          'Contraseña cambiada con éxito', context, () async {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al cambiar la contraseña'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Cambiar contraseña',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
