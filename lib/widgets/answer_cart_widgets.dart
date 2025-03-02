import '../helpers/paths.dart';

Widget cartWidget(BuildContext context, CartModel cart) {
  return GestureDetector(
    onTap: () async {
      await showCartDialog(context, cart);
    },
    child: Container(
      height: MediaQuery.of(context).size.height * 0.185,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   colorFilter: ColorFilter.mode(
        //       Theme.of(context).colorScheme.surface.withOpacity(0.99),
        //       BlendMode.src),
        //   image: const AssetImage(Assets.cartPaper),
        //   fit: BoxFit.cover,
        // ),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Text(
                  cart.contenido,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                "- ${cart.letraEmisor}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.08),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget responseWidget(
  BuildContext context,
  String letra,
  TextEditingController controller,
  String hintText,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xfefdf6ec),
      image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.secondary.withOpacity(0.99),
            BlendMode.src),
        image: const AssetImage(Assets.cartPaper),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.001),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sticky_note_2_rounded)),
            const Spacer(),
            Text(
              letra,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    ),
  );
}

Future<void> showCartDialog(BuildContext context, CartModel cart) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Text(
                      cart.contenido,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "- ${cart.letraEmisor}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ],
          ),
        ),
      );
    },
  );
}
