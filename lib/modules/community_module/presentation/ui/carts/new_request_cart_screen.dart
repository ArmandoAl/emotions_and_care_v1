import '../../../../../helpers/paths.dart';

class NewRequestCartScreen extends StatefulWidget {
  final int userId;
  final String userLetter;
  final bool isPatient;
  final Function(CartModel) onSend;
  const NewRequestCartScreen(
      {super.key,
      required this.userId,
      required this.userLetter,
      required this.isPatient,
      required this.onSend});

  @override
  State<NewRequestCartScreen> createState() => _NewRequestCartScreenState();
}

class _NewRequestCartScreenState extends State<NewRequestCartScreen> {
  TextEditingController controller = TextEditingController();
  bool isloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva carta'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06),
                  child: responseWidget(
                      context,
                      "- ${widget.userLetter.toUpperCase()}",
                      controller,
                      "Escribe una nota corta para pedir consejos de la comunidad"),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              children: [
                const Spacer(),
                !isloading
                    ? ElevatedButton(
                        onPressed: () async {
                          //validaciones
                          if (controller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'El contenido de la carta no puede estar vacío'),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isloading = true;
                          });

                          final cart = CartModel(
                              idEmisor: widget.userId,
                              letraEmisor: widget.userLetter.toUpperCase(),
                              contenido: controller.text);

                          await widget.onSend(cart);

                          setState(() {
                            isloading = false;
                          });

                          if (context.mounted) Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.2,
                            MediaQuery.of(context).size.height * 0.04,
                          ),
                          elevation: 5,
                        ),
                        child: const Text('Enviar'),
                      )
                    : const CircularProgressIndicator(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.06),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          ],
        ),
      ),
    );
  }
}
