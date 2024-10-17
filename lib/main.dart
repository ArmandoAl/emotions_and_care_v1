import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/assets/assets.dart';
import 'helpers/navigation_bloc.dart';
import 'helpers/paths.dart';
import 'modules/auth_module/presentation/ui/beggin_process_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.logo),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: uiCubit.state.themes[uiCubit.state.selectedTheme],
      home: BlocBuilder<BegginCubit, BegginState>(
        bloc: getIt<BegginCubit>(), // No llamamos a getUser aquí
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
                : state.status == BegginStatus.loged
                    ? const LoginStack() // Aquí muestra la pantalla de login cuando está logeado
                    : const BegginProcessController(),
          );
        },
      ),
    );
  }
}
