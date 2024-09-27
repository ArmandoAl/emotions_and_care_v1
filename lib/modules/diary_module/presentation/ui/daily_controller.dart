import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../config/assets/assets.dart';
import '../../../../helpers/paths.dart';

class DailyController extends StatefulWidget {
  final PatientModel patientModel;
  final Function(int)? changeIndex;
  final bool isPattient;
  const DailyController(
      {super.key,
      required this.patientModel,
      required this.changeIndex,
      required this.isPattient});

  @override
  State<DailyController> createState() => _DailyControllerState();
}

class _DailyControllerState extends State<DailyController> {
  @override
  void initState() {
    super.initState();
    context.read<DailyCubit>().getNotes(widget.patientModel.id!);
    context.read<EmotionCubit>().getEmotions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
        bloc: context.read<DailyCubit>(),
        builder: (context, state) {
          if (state.result == DailyResult.error) {
            return const Center(
              child: Text('Error',
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.none)),
            );
          }

          final notes = widget.isPattient
              ? state.notes
              : state.notes
                  .where((element) => element.visible == true)
                  .toList();

          return Scaffold(
            body: state.result == DailyResult.loading
                ? Center(
                    child: Lottie.asset(Assets.brainLoading),
                  )
                : notes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Este es tu diario personal, aquí podrás escribir tus pensamientos y emociones. \n\n ¡Comienza a escribir!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : DailyScreen(
                        notes: notes,
                        onNoteTap: (note) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailScreen(note: note)));
                        },
                        onLongTap: (NoteModel note) {
                          context.read<DailyCubit>().remove(note);
                        },
                        reload: () async {
                          context
                              .read<DailyCubit>()
                              .getNotes(widget.patientModel.id!);
                        },
                      ),
            floatingActionButton: widget.isPattient
                ? FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewNoteScreen(
                              id: widget.patientModel.id!,
                              patientModel: widget.patientModel,
                              onNoteCreated: (NoteModel note, id) async {
                                GoalWithNote res = await context
                                    .read<DailyCubit>()
                                    .addNote(note, id);

                                if (res.goalModel != null && context.mounted) {
                                  final UICubit uiProvider =
                                      Provider.of<UICubit>(context,
                                          listen: false);

                                  await uiProvider
                                      .getSticker(res.goalModel!.idSticker!);

                                  if (context.mounted) {
                                    await showStickerDialog(
                                        context, res.goalModel!);
                                  }
                                }
                              },
                              onVisible: (visible) {
                                context
                                    .read<DailyCubit>()
                                    .changeVisibility(visible);
                              } //onVisible
                              )));
                    },
                    child: const Icon(
                      Icons.border_color_outlined,
                      color: Colors.white,
                    ),
                  )
                : null,
          );
        });
  }
}

Future<void> showStickerDialog(BuildContext context, GoalModel goal) async {
  final uiProvider = getIt<UICubit>();
  final sticker = uiProvider.state.stickers.last;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(goal.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(goal.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('¡Nuevo sticker desbloqueado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.028,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              CachedNetworkImage(
                imageUrl: sticker.url!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1C8AAD),
                ),
                onPressed: () async {
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: const Text('Recoger sticker',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
