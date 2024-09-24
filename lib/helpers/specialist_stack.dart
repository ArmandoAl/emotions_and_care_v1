import 'dart:async';
import 'package:emotions_and_care_v1/helpers/paths.dart';

class SpecialistStack extends StatefulWidget {
  const SpecialistStack({super.key});

  @override
  State<SpecialistStack> createState() => _SpecialistStackState();
}

class _SpecialistStackState extends State<SpecialistStack> {
  int index = 0;
  late double animatedHeight = MediaQuery.of(context).size.height * 0.08;
  Widget help = const SizedBox();

  void changeState() {
    setState(() {
      animatedHeight =
          animatedHeight == MediaQuery.of(context).size.height * 0.08
              ? MediaQuery.of(context).size.height * 0.4
              : MediaQuery.of(context).size.height * 0.08;
    });

    if (animatedHeight >= MediaQuery.of(context).size.height * 0.3) {
      Timer(const Duration(milliseconds: 200), () {
        setState(() {
          help = Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help,
                  color: Colors.black,
                  size: 50,
                ),
              ),
            ],
          );
        });
      });
    } else {
      setState(() {
        help = const SizedBox();
      });
    }
  }

  void changeIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    BegginCubit userProvider = getIt<BegginCubit>();
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          SpecialistPattientsController(
            idUser: userProvider.state.specialistModel!.id!,
            changeIndex: (int newIndex) {
              changeIndex(0);
            },
          ),
          ScheduleController(
              patientModel: null,
              changeIndex: changeIndex,
              isPattient: false,
              especialistaModel: userProvider.state.specialistModel!),
          PattientsDatesController(
            idUser: userProvider.state.specialistModel!.id!,
            changeIndex: (int newIndex) {
              changeIndex(0);
            },
          ),
          SettingsController(
              userProvider: userProvider,
              changeIndex: changeIndex,
              isPattient: false)
        ],
      ),
      bottomNavigationBar: bottomBar(context, index, (index) {
        changeIndex(index);
      }),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GlobalCommunityController(
                changeIndex: changeIndex,
                specialistModel: userProvider.state.specialistModel!,
                isPatient: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.note_alt_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}

Widget bottomBar(BuildContext context, int index, Function setIndex) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                setIndex(0);
              },
              icon: const Icon(
                Icons.people,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                setIndex(1);
              },
              icon: const Icon(
                Icons.date_range_sharp,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                setIndex(2);
              },
              icon: const Icon(
                Icons.schedule,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                setIndex(3);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ));
}
