import 'package:emotions_and_care_v1/helpers/paths.dart';

import 'change_password_scree.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final Future<bool> Function(String) recoverPassword;

  final Future<bool> Function(String mail, String code) validateCode;

  final Future<bool> Function(String mail, String pasword) changePassword;

  const ForgotPasswordScreen(
      {super.key,
      required this.recoverPassword,
      required this.validateCode,
      required this.changePassword});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController controller = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  bool mailSend = false;

  @override
  Widget build(BuildContext context) {
    if (mailSend == true) {
      return Scaffold(
          appBar: const HeaderWidget(
            title: 'Olvide mi contraseña',
            isForReturn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //hacer lo mismo que abajo, pon un campo para poner el codigo que se le mando por correo, arriba del textfield pon el aviso de que se debe de revisar la bandeja de entrada y un boton para validar
                  const Text(
                    'Revisa tu bandeja de entrada y agrega el código que se te envió',
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
                      controller: codeController,
                      decoration: const InputDecoration(
                        labelText: 'Código',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (codeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, ingresa un código'),
                          ),
                        );

                        return;
                      }

                      bool? res;

                      await showLoadingdialog("Cargando datos", context,
                          () async {
                        res = await widget.validateCode(
                            controller.text, codeController.text);
                      });

                      if (res == true && context.mounted) {
                        if (context.mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(
                                email: controller.text,
                                changePassword: (String password) async {
                                  return await widget.changePassword(
                                      controller.text, password);
                                },
                              ),
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al enviar el código'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                ],
              ),
            ),
          ));
    } else {
      return Scaffold(
          appBar: const HeaderWidget(
            title: 'Olvide mi contraseña',
            isForReturn: true,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Agrega tu correo electrónico para restablecer tu contraseña',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        bool? res;

                        await showLoadingdialog("Cargando datos", context,
                            () async {
                          res = await widget.recoverPassword(controller.text);
                        });

                        if (res == true && context.mounted) {
                          await showMessageDialog(context, 'Correo enviado',
                              'Se ha enviado un correo a ${controller.text} para restablecer tu contraseña');

                          if (context.mounted) {
                            Navigator.pop(context);
                          }

                          setState(() {
                            mailSend = true;
                          });
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error al enviar el correo'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}
