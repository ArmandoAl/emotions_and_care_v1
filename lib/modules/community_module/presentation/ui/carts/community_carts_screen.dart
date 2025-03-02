import 'package:card_swiper/card_swiper.dart';
import '../../../../../helpers/paths.dart';

class CommunityCartsScreen extends StatefulWidget {
  final List<CartModel> carts;
  final void Function(CartModel) onCartTap;
  const CommunityCartsScreen(
      {super.key, required this.onCartTap, required this.carts});

  @override
  State<CommunityCartsScreen> createState() => _CommunityCartsScreenState();
}

class _CommunityCartsScreenState extends State<CommunityCartsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("Selecciona una carta para brindar apoyo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                decoration: TextDecoration.none,
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Swiper(
            onTap: (index) {
              widget.onCartTap(widget.carts[index]);
            },
            itemCount: widget.carts.length,
            itemWidth: MediaQuery.of(context).size.width * 0.85,
            itemHeight: MediaQuery.of(context).size.height * 0.675,
            layout: SwiperLayout.STACK,
            //I just need the cards more rounded, thts it
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.99),
                        BlendMode.src),
                    image: const AssetImage(
                      Assets.cartPaper,
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.025),
                        child: SingleChildScrollView(
                          child: Text(
                            widget.carts[index].contenido,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Text(
                          "${widget.carts[index].respuestas!.length} respuestas",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "- ${widget.carts[index].letraEmisor}",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
