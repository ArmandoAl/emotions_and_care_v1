import 'package:cached_network_image/cached_network_image.dart';
import '../helpers/paths.dart';

Future<void> showItemsDialog(BuildContext context, String title, int position,
    UICubit uiCubit, UIState uiState) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title, style: const TextStyle(color: Colors.black)),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.4,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: title == "Tus stickers"
                ? uiState.stickers!.length
                : uiState.flowers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final authCubit = context.read<BegginCubit>();

                  if (title == "Tus stickers") {
                    uiCubit.setStickerInUse(authCubit.state.patientModel!.id!,
                        uiState.stickers![index], position);

                    if (authCubit.state.registerPatientFlow! ==
                        "firstTestCompleted") {
                      await showMessageDialog(context, "",
                          "Selecciona la palomita azul superior para continuar. ");
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  } else {
                    uiCubit.setFlowerInInterface(
                        authCubit.state.patientModel!.id!,
                        uiState.flowers[index],
                        position);

                    if (authCubit.state.registerPatientFlow! ==
                        "firstTestCompleted") {
                      await showMessageDialog(
                        context,
                        "Añade stickers a tu jardín",
                        "¡Decora tu jardín con stickers! |Añade un toque personal a tu espacio eligiendo diversos stickers. |Cada sticker que elijas será un recordatorio de la importancia de celebrar cada pequeño logro en tu camino hacia el bienestar. |Selecciona uno de los espacios en tu jardín y añade los stickers que has conseguido.",
                      );
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: title == "Tus stickers"
                    ? CachedNetworkImage(
                        imageUrl: uiState.stickers![index].url ?? "",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.sticky_note_2),
                      )
                    : CachedNetworkImage(
                        imageUrl: uiState.flowers[index].flower
                            .urls![uiState.flowers[index].state].url,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              );
            },
          ),
        ),
      );
    },
  );
}

Future<void> showCustomDialog(
  BuildContext context,
  UICubit uiCubit,
) async {
  //l want that the dialog has a background image

  AnimationController animationController = AnimationController(
    vsync: Navigator.of(context),
    duration:
        const Duration(milliseconds: 500), // Changed to 500ms for better effect
  );

  // Remove or comment out the unused animation
  // Animation<Color> animationn = ColorTween(
  //   begin: Colors.white,
  //   end: Colors.green,
  // ).animate(animationController);

  // Add scale animation
  Animation<double> scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 1.1,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ),
  );

  //que este en ciclo infinito
  animationController.repeat(reverse: true);

  final userFlower = uiCubit.state.currentFlower;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final notificationModel =
              state.items.isEmpty ? null : state.items.first;

          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.paper),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        notificationModel!.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: SingleChildScrollView(
                          child: Text(
                            notificationModel.description,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                    notificationModel.type ==
                            NotificationType.notificacionRecomendacion
                        ? Row(
                            children: [
                              const Spacer(),
                              const Text("Completado: ",
                                  style: TextStyle(color: Colors.black)),
                              Checkbox(
                                  value: notificationModel.completed,
                                  onChanged: (value) {
                                    context
                                        .read<HomeCubit>()
                                        .changeNotificationCompleteStatud(
                                            notificationModel.id);

                                    //TODO: Poner en back
                                    //tenemos que cambiar la liogica, en el back, la funcion de delete notification va modificar la variable nueva de later y eso servira para determinar si se puede mostar o no en las notificaciones

                                    //haz pop despues de 2 segundos
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.075,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    // notificationModel.type ==
                    //         NotificationType.notificacionRecomendacion
                    //     ? Row(
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //             child: const Padding(
                    //               padding: EdgeInsets.only(left: 15.0),
                    //               child: Text("Mas tarde",
                    //                   style: TextStyle(
                    //                       color: Colors.brown,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.bold)),
                    //             ),
                    //           )
                    //         ],
                    //       )
                    //     : const SizedBox(),
                    notificationModel.type ==
                            NotificationType.notificacionRecomendacion
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015)
                        : const SizedBox(),
                    if (userFlower != null &&
                        userFlower.state < 5 &&
                        notificationModel.type ==
                            NotificationType.growNotifications)
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: scaleAnimation.value,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final BegginCubit begginCubit =
                                        context.read<BegginCubit>();
                                    final HomeCubit homeCubit =
                                        context.read<HomeCubit>();

                                    if (userFlower.state < 5) {
                                      begginCubit
                                          .changeStatus(BegginStatus.growing);

                                      homeCubit.growFlowerinBack(
                                          begginCubit.state.patientModel!.id!,
                                          uiCubit.state.currentFlower!
                                              .userFlowerId);
                                    }

                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    "Crecer mi planta",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> showMessageDialog(
    BuildContext context, String title, String message,
    {bool dimiss = true}) async {
  await showDialog(
    context: context,
    barrierDismissible: dimiss,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message.replaceAll("|", "\n"),
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
