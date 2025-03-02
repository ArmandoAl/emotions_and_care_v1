import 'package:cached_network_image/cached_network_image.dart';
import '../helpers/paths.dart';

Widget macetaConPlanta(
    BuildContext context,
    bool customEnable,
    UICubit uiProvider,
    UIState uiState,
    AnimationController? animationController,
    Animation? animation) {
  return GestureDetector(
    onTap: () async {
      if (customEnable == true) {
        await showItemsDialog(context, "Tus plantas", 0, uiProvider, uiState);
      }
    },
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            bottom: 45,
            left: MediaQuery.of(context).size.width * 0.345,
            child: uiProvider.state.currentFlower != null
                ? CachedNetworkImage(
                    imageUrl: uiState.currentFlower!.flower
                        .urls![uiState.currentFlower!.state].url,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const SizedBox(),
          ),
          Positioned(
            bottom: -11,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 83, 79, 79).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(-1, 12),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: customEnable && animationController != null
                  ? AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Image.asset(
                          Assets.pot,
                          color: animation!.value,
                        );
                      },
                    )
                  : Image.asset(
                      Assets.pot,
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}
