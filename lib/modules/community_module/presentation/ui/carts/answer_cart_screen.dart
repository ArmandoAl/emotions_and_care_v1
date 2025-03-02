import '../../../../../helpers/paths.dart';

class AnswerCartScreen extends StatefulWidget {
  final CartModel cart;
  final int userId;
  final String letraEmisor;
  final Function onSend;
  const AnswerCartScreen(
      {super.key,
      required this.cart,
      required this.userId,
      required this.letraEmisor,
      required this.onSend});

  @override
  State<AnswerCartScreen> createState() => _AnswerCartScreenState();
}

class _AnswerCartScreenState extends State<AnswerCartScreen> {
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
      appBar: HeaderWidget(
          title: 'Escribe una carta para - ${widget.cart.letraEmisor[0]}',
          isForReturn: true),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: cartWidget(
                context,
                widget.cart,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.575,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: responseWidget(context, "- ${widget.letraEmisor[0]}",
                    controller, "Escribe tu respuesta"),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
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

                    final cartResponse = CartResponse(
                      id: null,
                      contenido: controller.text,
                      idReceptor: widget.userId,
                      letraReceptor: widget.letraEmisor[0],
                      leida: false,
                    );

                    await widget.onSend(cartResponse);

                    setState(() {
                      isloading = false;
                    });

                    if (context.mounted) Navigator.pop(context);
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
                  child: isloading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Enviar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
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
