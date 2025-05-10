import 'package:emotions_and_care_v1/firebase_options.dart';
import 'package:emotions_and_care_v1/helpers/notifications_cubit.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/logic/patient_request_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helpers/navigation_bloc.dart';
import 'helpers/paths.dart';
import 'modules/auth_module/presentation/ui/beggin_process_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BegginCubit>(
          create: (context) => getIt<BegginCubit>(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => getIt<NavigationBloc>(),
        ),
        BlocProvider<EmotionCubit>(
          create: (context) => getIt<EmotionCubit>(),
        ),
        BlocProvider<CommunityCubit>(
          create: (context) => getIt<CommunityCubit>(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => getIt<HomeCubit>(),
        ),
        BlocProvider<PattientsCubit>(
          create: (context) => getIt<PattientsCubit>(),
        ),
        BlocProvider<DailyCubit>(
          create: (context) => getIt<DailyCubit>(),
        ),
        BlocProvider<ScheduleCubit>(
          create: (context) => getIt<ScheduleCubit>(),
        ),
        BlocProvider<TestCubit>(
          create: (context) => getIt<TestCubit>(),
        ),
        BlocProvider<UICubit>(
          create: (context) => getIt<UICubit>(),
        ),
        BlocProvider<PattientsDatesCubit>(
          create: (context) => getIt<PattientsDatesCubit>(),
        ),
        BlocProvider<PatientsRequestCubit>(
          create: (context) => getIt<PatientsRequestCubit>(),
        ),
        BlocProvider<FirebaseNotificationsCubit>(
          create: (context) => getIt<FirebaseNotificationsCubit>(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UICubit>().setUpUI();
      context.read<BegginCubit>().getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiCubit = context.watch<UICubit>();

    if (uiCubit.state.themes.isEmpty) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Emotions and Care',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emotions and Care',
      theme: uiCubit.state.themes[uiCubit.state.selectedTheme],
      home: BlocBuilder<BegginCubit, BegginState>(
        bloc: getIt<BegginCubit>(),
        builder: (context, state) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: state.status == BegginStatus.start ||
                      state.status == BegginStatus.loading
                  ? const Scaffold(
                      backgroundColor: Colors.white,
                      body: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : state.status == BegginStatus.notLoged ||
                          state.status == BegginStatus.errorInRegister
                      ? const BegginProcessController()
                      : const LoginStack() // Aquí muestra la pantalla de login cuando está logeado

              );
        },
      ),
    );
  }
}
