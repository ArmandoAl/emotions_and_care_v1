import 'package:emotions_and_care_v1/modules/auth_module/presentation/ui/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import '../../../../config/assets/assets.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(
      String email, String password, bool isRememberPassword) onLogin;
  final void Function() onRegister;
  final Future<bool> Function(String email) recoverPassword;
  final Future<bool> Function(String mail, String code) validateCode;
  final Future<bool> Function(String mail, String pasword) changePassword;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.recoverPassword,
    required this.validateCode,
    required this.changePassword,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;
  bool isRememberPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff1C8AAD),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset(
                Assets.logo,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffE3EDF3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        _customTextFieldWidget(
                            context,
                            emailController,
                            'Correo electrónico',
                            const Icon(Icons.email, color: Colors.black),
                            null, () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        }, TextInputType.emailAddress),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        _customTextFieldWidget(
                            context,
                            passwordController,
                            'Contraseña',
                            const Icon(Icons.lock, color: Colors.black),
                            isPasswordVisible, () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        }, TextInputType.visiblePassword),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // Navegar a la pantalla de recuperación de contraseña
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen(
                                      recoverPassword: (String mail) async {
                                        return await widget
                                            .recoverPassword(mail);
                                      },
                                      validateCode:
                                          (String mail, String code) async {
                                        return await widget.validateCode(
                                            mail, code);
                                      },
                                      changePassword:
                                          (String mail, String pasword) async {
                                        return await widget.changePassword(
                                            mail, pasword);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Text('¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                      fontFamily:
                                          'Gilroy', // Usa la fuente personalizada
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: isRememberPassword,
                                onChanged: (value) {
                                  setState(() {
                                    isRememberPassword = value!;
                                  });
                                }),
                            Text('Recordar contraseña',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await widget.onLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    isRememberPassword);
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1C8AAD),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                        fontFamily:
                                            'Gilroy', // Usa la fuente personalizada
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        const Row(children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('O'),
                          ),
                          Expanded(child: Divider()),
                        ]),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text('¿Eres nuevo? ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      color: Colors.black)),
                              GestureDetector(
                                onTap: () {
                                  widget.onRegister();
                                },
                                child: Text('Regístrate',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                        color: const Color(0xff1C8AAD))),
                              ),
                              const Spacer(),
                            ]),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

Widget _customTextFieldWidget(
    BuildContext context,
    TextEditingController controller,
    String hintText,
    Icon icon,
    bool? oscureText,
    Function() onTap,
    TextInputType? type) {
  return SizedBox(
    child: Column(
      children: [
        Row(
          children: [
            Text(hintText,
                style: TextStyle(
                    fontFamily: 'Gilroy', // Usa la fuente personalizada
                    fontWeight: FontWeight.w600, // Gilroy-Regular
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black)),
            const Spacer()
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: type,
                obscureText: oscureText ?? false,
                controller: controller,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  //just border in the bottom of the textfield
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  icon: icon,
                ),
              ),
            ),
            oscureText != null
                ? IconButton(
                    onPressed: () {
                      onTap();
                    },
                    icon: Icon(
                      oscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox(
                    width: 0,
                  ),
          ],
        ),
      ],
    ),
  );
}
