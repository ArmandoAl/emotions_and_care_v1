import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/utils_functions/show_message.dart';
import '../../../../helpers/paths.dart';

class BegginProcessController extends StatefulWidget {
  const BegginProcessController({super.key});

  @override
  State<BegginProcessController> createState() =>
      _BegginProcessControllerState();
}

class _BegginProcessControllerState extends State<BegginProcessController> {
  late BegginCubit userProvider;
  late UICubit uiProvider;

  @override
  void initState() {
    super.initState();
    userProvider = getIt<BegginCubit>();
    uiProvider = getIt<UICubit>();
  }

  @override
  Widget build(BuildContext context) {
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

                        if (result == 'error' && context.mounted) {
                          showMessage(context, 'Error al iniciar sesión');

                          return;
                        }

                        if (result != 'success' && context.mounted) {
                          showMessage(context, result);

                          return;
                        }

                        if (context.mounted) Navigator.pop(context);
                      }, onRegister: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterProcessScreen(
                                      onPatientRegister: (PatientModel patient,
                                          PageController pageController) async {
                                        if (validatePhone(patient.phone!) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un número de teléfono válido');
                                          return;
                                        }

                                        if (validateEmail(patient.email!) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un correo válido');
                                          return;
                                        }

                                        if (patient.bornDate!.year >
                                            DateTime.now().year - 18) {
                                          showMessage(context,
                                              'Debes tener al menos 18 años para registrarte');
                                          return;
                                        }

                                        if (patient.password!.length < 6) {
                                          showMessage(context,
                                              'La contraseña debe tener al menos 6 caracteres');
                                          return;
                                        }

                                        final result = await userProvider
                                            .registerPatient(patient);

                                        if (result != 'success' &&
                                            context.mounted) {
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
                                        if (validatePhone(specialist.phone!) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un número de teléfono válido');
                                          return;
                                        }

                                        if (validateEmail(specialist.email!) ==
                                            false) {
                                          showMessage(context,
                                              'Por favor, ingrese un correo válido');

                                          return;
                                        }

                                        if (specialist.password!.length < 6) {
                                          showMessage(context,
                                              'La contraseña debe tener al menos 6 caracteres');
                                          return;
                                        }

                                        final result = await userProvider
                                            .registerSpecialist(specialist);

                                        if (result != 'success' &&
                                            context.mounted) {
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
