import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../config/utils_functions/show_message.dart';
import '../../../../helpers/paths.dart';

class BegginProcessController extends StatefulWidget {
  const BegginProcessController({super.key});

  @override
  State<BegginProcessController> createState() =>
      _BegginProcessControllerState();
}

class _BegginProcessControllerState extends State<BegginProcessController> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return BlocBuilder<BegginCubit, BegginState>(
      bloc: context.read<BegginCubit>(),
      builder: (context, state) {
        return StartScreen(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                          onLogin: (String email, String password) async {
                        if (email.isEmpty || password.isEmpty) {
                          showMessage(
                              context, 'Por favor, rellene todos los campos');
                          return;
                        }

                        if (validateEmail(email) == false) {
                          showMessage(
                              context, 'Por favor, ingrese un correo válido');
                          return;
                        }

                        final result =
                            await userProvider.multiLogin(email, password);

                        if (result == 'error') {
                          showMessage(context, 'Error al iniciar sesión');

                          return;
                        }

                        if (result != 'success') {
                          showMessage(context, result);

                          return;
                        }

                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(
                        //     builder: (context) => const GuideFlowController(),
                        //   ),
                        //   (route) => false,
                        // );
                      }, onRegister: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterProcessScreen(
                                      onPatientRegister: (PatientModel patient,
                                          PageController pageController) async {
                                        if (validatePhone(patient.phone) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un número de teléfono válido');
                                          return;
                                        }

                                        if (validateEmail(patient.email) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un correo válido');
                                          return;
                                        }

                                        // if (patient.bornDate.year >
                                        //     DateTime.now().year - 17) {
                                        //   showMessage(context,
                                        //       'Debes tener al menos 17 años para registrarte');
                                        //   return;
                                        // }

                                        if (patient.password.length < 6) {
                                          showMessage(context,
                                              'La contraseña debe tener al menos 6 caracteres');
                                          return;
                                        }

                                        final result = await userProvider
                                            .registerPattient(patient);

                                        if (result != 'success') {
                                          showMessage(context, result);
                                          return;
                                        }

                                        pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut);
                                      },
                                      onSpecialistrRegister: (SpecialistModel
                                              specialist,
                                          PageController pageController) async {
                                        if (validatePhone(specialist.phone) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un número de teléfono válido');
                                          return;
                                        }

                                        if (validateEmail(specialist.email) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un correo válido');

                                          return;
                                        }

                                        if (specialist.password.length < 6) {
                                          showMessage(context,
                                              'La contraseña debe tener al menos 6 caracteres');
                                          return;
                                        }

                                        final result = await userProvider
                                            .registerSpecialist(specialist);

                                        if (result != 'success') {
                                          showMessage(context, result);
                                          return;
                                        }

                                        pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut);
                                      },
                                    )));
                      })),
            );
          },
        );
      },
    );
  }
}
