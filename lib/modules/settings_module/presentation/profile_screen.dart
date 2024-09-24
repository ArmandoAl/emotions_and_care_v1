import '../../../helpers/paths.dart';

class ProfileScreen extends StatefulWidget {
  final PatientModel? patientModel;
  final SpecialistModel? specialistModel;
  final bool isPatient;
  final BegginCubit userProvider;

  const ProfileScreen(
      {super.key,
      this.patientModel,
      this.specialistModel,
      required this.isPatient,
      required this.userProvider});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerSecondPassword = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controllerSecondPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información personal'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            SizedBox(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person, size: 100)),
                  Text(
                    "Nombre de usuario: ",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black),
                  ),
                  Text(
                    widget.isPatient
                        ? textToUpperCateFirstLetter(
                            widget.userProvider.state.patientModel!.name!)
                        : textToUpperCateFirstLetter(
                            widget.userProvider.state.specialistModel!.name!),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black),
                  ),
                  !widget.isPatient
                      ? const Text("Codigo de vinculación: ")
                      : Container(),
                  !widget.isPatient
                      ? Text(
                          widget.specialistModel!.tokenForRelate!,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            profileItem(
              context,
              widget.isPatient
                  ? widget.userProvider.state.patientModel!.email!
                  : widget.userProvider.state.specialistModel!.email!,
              "Correo electrónico",
              Icon(
                Icons.email,
                color: const Color(0xff1C8AAD),
                size: MediaQuery.of(context).size.width * 0.065,
              ),
              () async {
                await showChangeDataDialog(
                    context,
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!.email!
                        : widget.userProvider.state.specialistModel!.email!,
                    "Correo electrónico",
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!
                        : widget.userProvider.state.specialistModel!,
                    controller, () {
                  if (validateEmail(controller.text) == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("El correo electrónico no es válido"),
                      ),
                    );
                    return "error";
                  }

                  return "success";
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            profileItem(
              context,
              widget.isPatient
                  ? widget.userProvider.state.patientModel!.phone!
                  : widget.userProvider.state.specialistModel!.phone!,
              "Teléfono",
              Icon(
                Icons.phone,
                color: const Color(0xff1C8AAD),
                size: MediaQuery.of(context).size.width * 0.065,
              ),
              () async {
                await showChangeDataDialog(
                    context,
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!.phone!
                        : widget.userProvider.state.specialistModel!.phone!,
                    "Teléfono",
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!
                        : widget.userProvider.state.specialistModel!,
                    controller, () {
                  if (controller.text.length != 10 ||
                      validatePhone(controller.text) == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("El teléfono no es válido"),
                      ),
                    );
                    return "error";
                  }

                  return "success";
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            profileItem(
              context,
              widget.isPatient
                  ? widget.userProvider.state.patientModel!.age.toString()
                  : widget.userProvider.state.specialistModel!.age.toString(),
              "Edad",
              Icon(
                Icons.person,
                color: const Color(0xff1C8AAD),
                size: MediaQuery.of(context).size.width * 0.065,
              ),
              () async {
                await showChangeDataDialog(
                    context,
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!.age.toString()
                        : widget.userProvider.state.specialistModel!.age
                            .toString(),
                    "Edad",
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!
                        : widget.userProvider.state.specialistModel!,
                    controller, () {
                  if (int.parse(controller.text) < 17 ||
                      int.parse(controller.text) > 100) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("La edad no es válida"),
                      ),
                    );
                    return "error";
                  }

                  return "success";
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            profileItem(
              context,
              widget.isPatient
                  ? widget.userProvider.state.patientModel!.password!
                  : widget.userProvider.state.specialistModel!.password!,
              "Contraseña",
              Icon(
                Icons.lock,
                color: const Color(0xff1C8AAD),
                size: MediaQuery.of(context).size.width * 0.065,
              ),
              () async {
                await showChangePasswordDialog(
                    context,
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!.password!
                        : widget.userProvider.state.specialistModel!.password!,
                    "Contraseña",
                    widget.isPatient
                        ? widget.userProvider.state.patientModel!
                        : widget.userProvider.state.specialistModel!,
                    widget.isPatient,
                    widget.userProvider,
                    controller,
                    controllerSecondPassword);
              },
            ),
            !widget.isPatient
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                : Container(),
            !widget.isPatient
                ? profileItem(
                    context,
                    widget.specialistModel!.ubication == ""
                        ? "No especificado"
                        : widget.specialistModel!.ubication!,
                    "Ubicación",
                    Icon(
                      Icons.lock,
                      color: const Color(0xff1C8AAD),
                      size: MediaQuery.of(context).size.width * 0.065,
                    ),
                    () async {})
                : Container(),
            !widget.isPatient
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                : Container(),
            !widget.isPatient
                ? profileItem(
                    context,
                    widget.specialistModel!.presentation == ""
                        ? "No especificado"
                        : widget.specialistModel!.presentation!,
                    "Institución",
                    Icon(
                      Icons.lock,
                      color: const Color(0xff1C8AAD),
                      size: MediaQuery.of(context).size.width * 0.065,
                    ),
                    () async {},
                  )
                : Container(),
            !widget.isPatient
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                : Container(),
            !widget.isPatient
                ? profileItem(
                    context,
                    widget.specialistModel!.focus!,
                    "Enfoque",
                    Icon(
                      Icons.lock,
                      color: const Color(0xff1C8AAD),
                      size: MediaQuery.of(context).size.width * 0.065,
                    ),
                    () async {},
                  )
                : Container(),
            !widget.isPatient
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                : Container(),
            !widget.isPatient
                ? profileItem(
                    context,
                    widget.userProvider.state.specialistModel!.institution == ""
                        ? "No especificado"
                        : widget
                            .userProvider.state.specialistModel!.institution!,
                    "Carta de presentación",
                    null,
                    () async {},
                  )
                : Container(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDeleteUserDialog(context, widget.userProvider);
                  },
                  child: Text(
                    "Eliminar cuenta",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        color: Colors.red),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}

Widget profileItem(BuildContext context, String text, String title, Icon? icon,
    Function onPress) {
  return GestureDetector(
    onTap: () {
      onPress();
    },
    child: Column(
      children: [
        Row(
          children: [
            icon ?? Container(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black),
                  ),
                  Text(
                    title == "Contraseña" ? "********" : text,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<void> showChangeDataDialog(
  BuildContext context,
  String text,
  String title,
  dynamic model,
  TextEditingController controller,
  Function onPress,
) {
  controller.text = text;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Cambiar $title"),
        content: TextField(
          keyboardType:
              title == "Teléfono" ? TextInputType.phone : TextInputType.text,
          controller: controller,
          decoration: InputDecoration(hintText: "Nuevo $title"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () async {
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("El campo no puede estar vacío"),
                  ),
                );
                return;
              }

              if (text == controller.text) {
                Navigator.of(context).pop();
                return;
              }

              String result = await onPress();

              if (context.mounted && result == "success") {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showChangePasswordDialog(
  BuildContext context,
  String text,
  String title,
  dynamic model,
  bool isPatient,
  BegginCubit userProvider,
  TextEditingController controller,
  TextEditingController controllerP,
) {
  final TextEditingController controller = TextEditingController();
  controller.text = text;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Cambiar $title"),
        content: TextField(
          obscureText: true,
          controller: controller,
          decoration: InputDecoration(hintText: "Nueva $title"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              if (isPatient) {
                // userProvider.updatePatientData(
                //   model,
                //   title,
                //   controller.text,
                // );
              } else {
                // userProvider.updateSpecialistData(
                //   model,
                //   title,
                //   controller.text,
                // );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showDeleteUserDialog(
    BuildContext context, BegginCubit userProvider) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Eliminar cuenta"),
        content: const Text("¿Estás seguro de que deseas eliminar tu cuenta?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () async {
              await userProvider
                  .deletePatient(userProvider.state.patientModel!.id!);

              // if (context.mounted) {
              //   Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //       builder: (context) => const GuideFlowController(),
              //     ),
              //     (route) => false,
              //   );
              // }
            },
          ),
        ],
      );
    },
  );
}
