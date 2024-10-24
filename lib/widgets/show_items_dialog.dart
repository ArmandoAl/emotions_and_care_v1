import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/assets/assets.dart';
import '../helpers/paths.dart';

Future<void> showItemsDialog(
    BuildContext context, String title, int position, UICubit uiCubit) async {
  showDialog(
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
                ? uiCubit.state.stickers!.length
                : uiCubit.state.flowers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final authCubit = context.read<BegginCubit>();

                  if (title == "Tus stickers") {
                    uiCubit.setStickerInUse(authCubit.state.patientModel!.id!,
                        uiCubit.state.stickers![index], position);
                  } else {
                    uiCubit.setCurrentFlower(uiCubit.state.flowers[index]);
                  }

                  Navigator.of(context).pop();
                },
                child: title == "Tus stickers"
                    ? CachedNetworkImage(
                        imageUrl: uiCubit.state.stickers![index].url ?? "",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.sticky_note_2),
                      )
                    : CachedNetworkImage(
                        imageUrl: uiCubit.state.flowers[index].flower
                            .urls![uiCubit.state.flowers[index].state].url,
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
  NotificationModel notification,
) async {
  //l want that the dialog has a background image
  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                    notification.title,
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
                        notification.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ),
                notification.type == NotificationType.notificacionRecomendacion
                    ? Row(
                        children: [
                          const Spacer(),
                          const Text("Realizado: ",
                              style: TextStyle(color: Colors.black)),
                          Checkbox(
                              value: false,
                              onChanged: (value) {
                                //  onCompletedChanged(value!);
                              }),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.075,
                          ),
                        ],
                      )
                    : const SizedBox(),
                notification.type == NotificationType.notificacionRecomendacion
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showMessageDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message,
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
