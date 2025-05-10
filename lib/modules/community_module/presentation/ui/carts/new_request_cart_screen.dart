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
      appBar: const HeaderWidget(title: '', isForReturn: true),
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
                      null,
                      "Escribe una nota corta para pedir consejos de la comunidad",
                      sticker: false),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            InkWell(
              onTap: () async {
                if (isloading) return;

                if (controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('El contenido de la carta no puede estar vacío'),
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
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: Center(
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Enviar",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.06),
          ],
        ),
      ),
    );
  }
}
