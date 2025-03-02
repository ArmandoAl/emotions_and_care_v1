import '../../../../helpers/paths.dart';

class RegisterProcessScreen extends StatefulWidget {
  final Future<void> Function(
          PatientModel patient, PageController pageController, bool remember)?
      onPatientRegister;
  final Future<void> Function(SpecialistModel specialist,
      PageController pageController, bool remember)? onSpecialistrRegister;
  const RegisterProcessScreen(
      {super.key, this.onPatientRegister, this.onSpecialistrRegister});

  @override
  State<RegisterProcessScreen> createState() => _RegisterProcessScreenState();
}

class _RegisterProcessScreenState extends State<RegisterProcessScreen> {
  TermsRepository termsRepository = TermsRepository();
  PageController pageController = PageController();
  bool? isPatient;
  bool? oscureText = true;
  String? termsText;
  String sex = "Masculino";
  bool isLoaing = false;
  DateTime? bornDate;
  bool isRemember = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController focusController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController ubicationController = TextEditingController();

  void setIsPatient(bool isPatient) async {
    if (isPatient) {
      termsRepository.getTerms(1).then((value) {
        setState(() {
          termsText = value;
        });
      });
    } else {
      termsRepository.getTerms(2).then((value) {
        setState(() {
          termsText = value;
        });
      });
    }

    setState(() {
      this.isPatient = isPatient;
    });
  }

  void setRemember(bool remember) {
    setState(() {
      isRemember = remember;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    licenseController.dispose();
    ageController.dispose();
    focusController.dispose();
    institutionController.dispose();
    ubicationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BegginCubit userProvider = getIt<BegginCubit>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffE3EDF3),
      ),
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return choiseUserType(context, pageController, isPatient,
                  (bool isPatient) async {
                setIsPatient(isPatient);
              });
            case 1:
              return terms(context, pageController, isPatient!, termsText);
            case 2:
              return registerForm(
                  context,
                  pageController,
                  isPatient!,
                  nameController,
                  emailController,
                  passwordController,
                  confirmPasswordController,
                  phoneController,
                  ageController,
                  institutionController,
                  ubicationController,
                  focusController,
                  sex,
                  (String value) {
                    setState(() {
                      sex = value;
                    });
                  },
                  licenseController,
                  (PatientModel patient) async {
                    await widget.onPatientRegister!(
                        patient, pageController, isRemember);
                  },
                  (SpecialistModel specialist) async {
                    await widget.onSpecialistrRegister!(
                        specialist, pageController, isRemember);
                  },
                  oscureText,
                  () {
                    setState(() {
                      oscureText = !oscureText!;
                    });
                  },
                  isLoaing,
                  () {
                    setState(() {
                      isLoaing = !isLoaing;
                    });
                  },
                  bornDate,
                  (DateTime value) {
                    setState(() {
                      bornDate = value;
                    });
                  },
                  isRemember,
                  setRemember);
            case 3:
              return welcomeMessage(
                  context,
                  isPatient,
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  userProvider);
            default:
              return Container();
          }
        },
      ),
    );
  }
}

Widget welcomeMessage(
  BuildContext context,
  bool? isPatient,
  String email,
  String password,
  BegginCubit userProvider,
) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: const Color(0xffE3EDF3),
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Te damos la bienvenida a Emotions&Care. ¡Disfruta y crece con nosotros!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ElevatedButton(
          onPressed: () async {
            await userProvider.multiLogin(email, password);
            if (context.mounted) Navigator.pop(context);
            if (context.mounted) Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2CB5E0),
            elevation: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Text('Continuar',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}

Widget registerForm(
  BuildContext context,
  PageController pageController,
  bool isPatient,
  TextEditingController nameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
  TextEditingController phoneController,
  TextEditingController ageController,
  TextEditingController institutionController,
  TextEditingController ubicationController,
  TextEditingController focusController,
  String sex,
  Function changeSex,
  TextEditingController? licenseController,
  Future<void> Function(PatientModel patient) onPatientRegister,
  Future<void> Function(SpecialistModel specialist) onSpecialistrRegister,
  bool? oscureText,
  void Function()? changeObscureText,
  bool isLoaing,
  void Function() setState,
  DateTime? bornDate,
  Function changeBornDate,
  bool isRemember,
  void Function(bool remember) setRemember,
) {
  return Scaffold(
    backgroundColor: const Color(0xffE3EDF3),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                const Spacer()
              ],
            ),
            Text(
              "¡Listo para empezar!",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.075,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "Por favor, rellena los siguientes campos, para acceder a nuestros servicios.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _customTextFieldForRegister(context, nameController, "Nombre",
                Icons.person, null, null, TextInputType.text),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _customTextFieldForRegister(context, emailController, "Correo",
                Icons.email, null, null, TextInputType.emailAddress),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            isPatient
                ? _customDataOfBornWiget(
                    context,
                    "Fecha de nacimiento",
                    Icons.calendar_today,
                    null,
                    null,
                    TextInputType.datetime,
                    bornDate, (DateTime value) {
                    changeBornDate(value);
                  })
                : _customTextFieldForRegister(context, ageController, "Edad",
                    Icons.person, null, null, TextInputType.number),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _genderCuestomDropDown(
                context, sex, "Genero", Icons.person, changeSex),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _customTextFieldForRegister(context, phoneController, "Teléfono",
                Icons.phone, null, null, TextInputType.phone),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            if (!isPatient)
              _customTextFieldForRegister(
                  context,
                  licenseController!,
                  "Cedula profesional",
                  Icons.credit_card,
                  null,
                  null,
                  TextInputType.text),
            if (!isPatient)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            if (!isPatient)
              _customTextFieldForRegister(
                  context,
                  focusController,
                  "Especialidad",
                  Icons.credit_card,
                  null,
                  null,
                  TextInputType.text),
            if (!isPatient)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            if (!isPatient)
              _customTextFieldForRegister(
                  context,
                  ubicationController,
                  "Ubicacion (Opcional)",
                  Icons.credit_card,
                  null,
                  null,
                  TextInputType.text),
            if (!isPatient)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            _customTextFieldForRegister(
              context,
              passwordController,
              "Contraseña",
              Icons.lock,
              oscureText,
              changeObscureText,
              TextInputType.text,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _customTextFieldForRegister(
              context,
              confirmPasswordController,
              "Confirmar contraseña",
              Icons.lock,
              oscureText,
              null,
              TextInputType.text,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Checkbox(
                    value: isRemember,
                    onChanged: (value) {
                      setRemember(value!);
                    }),
                Text(
                  "Recordar mis datos",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2CB5E0),
                  elevation: 5,
                ),
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, rellena todos los campos'),
                      ),
                    );
                    return;
                  }

                  if (isPatient && bornDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Por favor, selecciona tu fecha de nacimiento'),
                      ),
                    );
                    return;
                  }

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                      ),
                    );
                    return;
                  }

                  if (isPatient == false) {
                    if (licenseController!.text.isEmpty ||
                        focusController.text.isEmpty ||
                        ageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor, rellena todos los campos de especialista'),
                        ),
                      );
                      return;
                    }
                  }

                  //validar numero y correo
                  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                      .hasMatch(emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Correo no valido'),
                      ),
                    );
                    return;
                  }

                  if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Telefono no valido'),
                      ),
                    );
                    return;
                  }

                  setState();

                  if (isPatient) {
                    await onPatientRegister(PatientModel(
                      id: 0,
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      sex: sex,
                      termsClass: TermAndConditions(
                        id: 1,
                        terms: "Términos y condiciones",
                      ),
                      type: UserType.patient,
                      specialist: null,
                      token:
                          'jknbvibnrwevruibweqig4wufinj6hrveuheic4buwn4ivh2ug54ifwhvn6g354c8rytaejke7jrhaeg456k7el8kt7jrsteahrgef${passwordController.text}',
                      tokenForRelate: '',
                      settings: null,
                      bornDate: bornDate!,
                    ));
                  } else {
                    await onSpecialistrRegister(SpecialistModel(
                      id: 0,
                      professionalLicense: licenseController!.text,
                      patients: [],
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      sex: sex,
                      age: int.parse(ageController.text),
                      termsClass: TermAndConditions(
                        id: 2,
                        terms: "Términos y condiciones",
                      ),
                      type: UserType.specialist,
                      token:
                          'jknbvibnrwevruibweqig4wufinj6hrveuheic4buwn4ivh2ug54ifwhvn6g354c8rytaejke7jrhaeg456k7el8kt7jrsteahrgef${passwordController.text}',
                      tokenForRelate: '',
                      bornDate: DateTime.now(),
                      focus: focusController.text,
                      institution: institutionController.text,
                      ubication: ubicationController.text,
                    ));
                  }

                  setState();
                },
                child: isLoaing
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Registrarse",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _customTextFieldForRegister(
  BuildContext context,
  TextEditingController controller,
  String hintText,
  IconData icon,
  bool? obscureText, // Cambiado de bool? a bool
  void Function()? changeObscureText,
  TextInputType type,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.05,
      vertical: MediaQuery.of(context).size.height * 0.001,
    ),
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              hintText,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  decoration: TextDecoration.none),
            ),
            Text(
              "*",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.red,
                  decoration: TextDecoration.none),
            ),
            const Spacer()
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: type,
                obscureText:
                    obscureText ?? false, // Verificar si obscureText es nulo
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(icon),
                  //border just in the bottom,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            if (changeObscureText != null)
              IconButton(
                onPressed: changeObscureText,
                icon: Icon(
                  obscureText!
                      ? Icons.visibility_off
                      : Icons.visibility_outlined,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget terms(
  BuildContext context,
  PageController pageController,
  bool isPatient,
  String? termsText,
) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: const EdgeInsets.all(20),
    color: const Color(0xffE3EDF3),
    child: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          "Términos y condiciones",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.075,
              color: const Color(0xff2CB5E0),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Text(
                  termsText != null ? termsText.replaceAll("|", "\n") : "",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xf22cb5e0),
                    elevation: 5,
                  ),
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text("Aceptar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05)),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            GestureDetector(
              onTap: () {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              child: Text(
                "Rechazar",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          ],
        )
      ],
    ),
  );
}

Widget choiseUserType(
  BuildContext context,
  PageController pageController,
  bool? isPatient,
  Future<void> Function(bool isPatient) onChoise,
) {
  return Scaffold(
    backgroundColor: const Color(0xffE3EDF3),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              const Spacer()
            ],
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text("¡Hay que comenzar!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text("¿Eres un joven universitario/a, o un especialista?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await onChoise(true);
                        },
                        child: Image.asset(
                          isPatient != null && isPatient
                              ? Assets.pacienteHoverIcon
                              : Assets.pacienteIcon,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await onChoise(false);
                        },
                        child: Image.asset(
                            isPatient != null && isPatient == false
                                ? Assets.specialistHoverIcon
                                : Assets.specialistIcon),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: const Color(0xff1C8AAD),
      onPressed: () {
        if (isPatient != null) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, elige un tipo de usuario'),
            ),
          );
        }
      },
      child: Icon(Icons.arrow_forward,
          color: Colors.white, size: MediaQuery.of(context).size.width * 0.05),
    ),
  );
}

Widget _genderCuestomDropDown(
  BuildContext context,
  String sex,
  String title,
  IconData icon,
  Function changeSex,
) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.001),
    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.001),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(15),
    ),
    child: DropdownButton<String>(
      value: sex,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
      ),
      iconSize: 24,
      elevation: 16,

      //no underline
      underline: Container(
        height: 0,
      ),

      onChanged: (String? newValue) {
        changeSex(newValue!);
      },
      items: <String>['Masculino', 'Femenino', 'Otro']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}

Widget _customDataOfBornWiget(
  BuildContext context,
  String hintText,
  IconData icon,
  bool? obscureText, // Cambiado de bool? a bool
  void Function()? changeObscureText,
  TextInputType type,
  DateTime? bornDate,
  Function changeBornDate,
) {
  //this widget is for the date of born, it has to be a date picker widget for the day, month and year
  return GestureDetector(
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.input,
        helpText: "Selecciona tu fecha de nacimiento",
        cancelText: "Cancelar",
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1924),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        changeBornDate(picked);
      }
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.001,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    hintText,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "*",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: Colors.red,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bornDate != null
                        ? "${bornDate.day}/${bornDate.month}/${bornDate.year}"
                        : "Selecciona tu fecha de nacimiento",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
