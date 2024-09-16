import 'package:cached_network_image/cached_network_image.dart';

import '../helpers/paths.dart';

Widget stickerWidget(
    BuildContext context,
    StickerModel? sticker,
    AnimationController? controller,
    Animation<double>? animation,
    UIProvider uiProvider,
    int index,
    bool customEnable) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.2,
    height: MediaQuery.of(context).size.width * 0.2,
    child: Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            child: customEnable == true
                ? GestureDetector(
                    onTap: () async {
                      await showItemsDialog(
                          context, "Tus stickers", index, uiProvider);
                    },
                    child: AnimatedBuilder(
                        animation: controller!,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: animation!.value,
                            child: sticker != null
                                ? CachedNetworkImage(
                                    imageUrl: sticker.url!,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height:
                                        MediaQuery.of(context).size.width * 0.2,
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                    height: MediaQuery.of(context).size.width *
                                        0.05,
                                    margin: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(1, 3),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        }),
                  )
                : sticker != null
                    ? CachedNetworkImage(
                        imageUrl: sticker.url!,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                      )
                    : const SizedBox()),
      ],
    ),
  );
}
