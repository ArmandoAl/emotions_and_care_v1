import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../config/assets/assets.dart';
import '../../../../../helpers/paths.dart';

class CommunityCartsControoler extends StatefulWidget {
  final PatientModel? patient;
  final SpecialistModel? specialist;
  final bool isPatient;
  const CommunityCartsControoler(
      {super.key, this.patient, this.specialist, required this.isPatient});

  @override
  State<CommunityCartsControoler> createState() =>
      _CommunityCartsControolerState();
}

class _CommunityCartsControolerState extends State<CommunityCartsControoler> {
  @override
  void initState() {
    context.read<CommunityCubit>().initCommunity(
          widget.isPatient ? widget.patient!.id! : widget.specialist!.id!,
        );

    // //todo: remove after expo
    context.read<CommunityCubit>().getCartFromUser(
          widget.isPatient ? widget.patient!.id! : widget.specialist!.id!,
          widget.isPatient,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == CommunityStatus.loading) {
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Lottie.asset(Assets.brainLoading),
              ),
            ),
          );
        }

        final carts = state.cartFromCommunity;

        return Scaffold(
            appBar: HeaderWidget(
              title: 'Cartas de apoyo',
              isForReturn: true,
              action: widget.isPatient
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCartsController(
                                      patientModel: widget.patient,
                                      specialistModel: widget.specialist,
                                      isPatient: widget.isPatient,
                                    )));
                      },
                      child: Text('Buzón',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          )))
                  : null,
            ),
            body: CommunityCartsScreen(
              carts: carts,
              onCartTap: (CartModel cart) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerCartScreen(
                      cart: cart,
                      userId: widget.isPatient
                          ? widget.patient!.id!
                          : widget.specialist!.id!,
                      letraEmisor: widget.isPatient
                          ? widget.patient!.name!
                          : widget.specialist!.name!,
                      onSend: (CartResponse cartResponse) async {
                        GoalWithResponseCart res =
                            await context.read<CommunityCubit>().addResponse(
                                  cartResponse,
                                  cart.id!,
                                  widget.isPatient,
                                  widget.isPatient
                                      ? widget.patient!.id!
                                      : widget.specialist!.id!,
                                );
                        if (res.goalModel != null) {
                          final UICubit uiProvider = getIt<UICubit>();

                          await uiProvider
                              .getSticker(res.goalModel!.idSticker!);

                          if (context.mounted) {
                            await showStickerDialog(context, res.goalModel!);
                          }
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewRequestCartScreen(
                          userId: widget.isPatient
                              ? widget.patient!.id!
                              : widget.specialist!.id!,
                          userLetter: widget.isPatient
                              ? widget.patient!.name![0]
                              : widget.specialist!.name![0],
                          isPatient: widget.isPatient,
                          onSend: (CartModel cart) async {
                            GoalWithCart res =
                                await context.read<CommunityCubit>().addCart(
                                      cart,
                                      widget.isPatient
                                          ? widget.patient!.id!
                                          : widget.specialist!.id!,
                                      widget.isPatient,
                                    );

                            if (res.goalModel != null && context.mounted) {
                              final UICubit uiProvider = getIt<UICubit>();

                              await uiProvider
                                  .getSticker(res.goalModel!.idSticker!);

                              if (context.mounted) {
                                await showStickerDialog(
                                    context, res.goalModel!);
                              }
                            }
                          })),
                );
              },
              child:
                  const Icon(Icons.border_color_outlined, color: Colors.white),
            ));
      },
    );
  }
}
