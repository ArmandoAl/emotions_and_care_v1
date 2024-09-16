import '../../../../../config/assets/assets.dart';
import '../../../../../helpers/paths.dart';

class UserCartsScreen extends StatefulWidget {
  final List<CartModel> carts;
  final int userId;
  final int index;
  final Function(int) updateIndex;
  const UserCartsScreen(
      {super.key,
      required this.carts,
      required this.index,
      required this.updateIndex,
      required this.userId});

  @override
  State<UserCartsScreen> createState() => _UserCartsScreenState();
}

class _UserCartsScreenState extends State<UserCartsScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Text("Buzón",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.updateIndex(0);
                  },
                  child: Text("Recibidas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: widget.index == 0
                            ? Colors.grey[700]
                            : Colors.grey.withOpacity(0.5),
                        decoration: widget.index == 0
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.grey,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    widget.updateIndex(1);
                  },
                  child: Text("Enviadas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: widget.index == 1
                            ? Colors.grey[700]
                            : Colors.grey.withOpacity(0.5),
                        decoration: widget.index == 1
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: Colors.grey,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.carts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.07),
                      child: cartWidget(
                        context,
                        widget.carts[index],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.index == 0
                            ? widget.carts[index].respuestas!.length
                            //el intemCount sera de el numero de respuestas que tiene la carta y que el idReceptor sea el id del usuario
                            : widget.carts[index].respuestas!
                                .where((element) =>
                                    element.idReceptor == widget.userId)
                                .length,
                        itemBuilder: (context, indexResponse) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.08),
                            child: responseWidgetContainer(
                                context,
                                widget.index == 0
                                    ? widget
                                        .carts[index]
                                        .respuestas![indexResponse]
                                        .letraReceptor
                                    : widget.carts[index].respuestas!
                                        .where((element) =>
                                            element.idReceptor == widget.userId)
                                        .toList()[indexResponse]
                                        .letraReceptor,
                                widget.index == 0
                                    ? widget.carts[index]
                                        .respuestas![indexResponse].contenido
                                    : widget.carts[index].respuestas!
                                        .where((element) =>
                                            element.idReceptor == widget.userId)
                                        .toList()[indexResponse]
                                        .contenido,
                                widget.index),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget responseWidgetContainer(
    BuildContext context, String letra, String content, int index) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.85,
    height: MediaQuery.of(context).size.height * 0.6,
    decoration: BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.surface.withOpacity(0.99),
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.018,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            //sticker
            const Spacer(),
            Text(
              "- $letra",
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    ),
  );
}
