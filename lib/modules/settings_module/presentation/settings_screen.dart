import '../../../helpers/paths.dart';

class SettingsScreen extends StatefulWidget {
  final BegginCubit userProvider;
  final bool isPattient;
  final UICubit uiProvider;
  const SettingsScreen(
      {super.key,
      required this.userProvider,
      required this.isPattient,
      required this.uiProvider});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          headerItem(
            context,
            widget.isPattient ? widget.userProvider.state.patientModel! : null,
            widget.isPattient
                ? null
                : widget.userProvider.state.specialistModel!,
            widget.isPattient,
            widget.userProvider,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          widget.isPattient
              ? listItem(
                  context,
                  "Personalización",
                  Icon(
                    Icons.color_lens,
                    color: const Color.fromARGB(255, 216, 13, 182),
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomMenuScreen(
                          userProvider: widget.userProvider,
                          uiProvider: widget.uiProvider,
                        ),
                      ),
                    );
                  },
                )
              : Container(),
          widget.isPattient
              ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
              : Container(),
          widget.isPattient
              ? listItem(
                  context,
                  "Privacidad",
                  Icon(
                    Icons.privacy_tip,
                    color: const Color.fromARGB(255, 7, 110, 38),
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyScreen(
                          settings: widget.isPattient
                              ? widget.userProvider.state.patientModel!.settings
                              : widget
                                  .userProvider.state.patientModel!.settings,
                        ),
                      ),
                    );
                  },
                )
              : Container(),
          widget.isPattient
              ? SizedBox(height: MediaQuery.of(context).size.height * 0.05)
              : Container(),
          listItem(
            context,
            "Términos y Condiciones",
            Icon(
              Icons.description,
              color: const Color.fromARGB(255, 75, 11, 160),
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsScreen(
                    terms: widget.isPattient
                        ? widget
                            .userProvider.state.patientModel!.termsClass!.terms
                        : widget.userProvider.state.specialistModel!.termsClass!
                            .terms,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          listItem(
            context,
            "Acerca de",
            Icon(
              Icons.info,
              color: const Color.fromARGB(255, 231, 150, 19),
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          listItem(
            context,
            "Cerrar Sesión",
            Icon(
              Icons.logout,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: MediaQuery.of(context).size.width * 0.1,
            ),
            () {
              // print("cerrar sesion");
              widget.uiProvider.clean();
              widget.userProvider.logout();

              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

Widget listItem(
  BuildContext context,
  String title,
  Icon icon,
  Function onTap,
) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Text(
              title,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: MediaQuery.of(context).size.width * 0.05,
          )
        ],
      ),
    ),
  );
}

Widget headerItem(
  BuildContext context,
  PatientModel? patientModel,
  SpecialistModel? specialistModel,
  bool isPattient,
  BegginCubit userProvider,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            patientModel: patientModel,
            specialistModel: specialistModel,
            userProvider: userProvider,
            isPatient: isPattient,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: MediaQuery.of(context).size.width * 0.12,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textToUpperCateFirstLetter(isPattient
                      ? patientModel!.name!
                      : specialistModel!.name!),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                Text(
                  isPattient ? patientModel!.email! : specialistModel!.email!,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 30,
          )
        ],
      ),
    ),
  );
}
