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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          surface: Colors.grey[200],
          onSurface: Colors.grey[800],
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: BlocBuilder<BegginCubit, BegginState>(
        bloc: getIt<BegginCubit>()..getUser(),
        builder: (context, state) {
          if (state.status == BegginStatus.loading) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: state.status == BegginStatus.initial
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
                          Text("Cagando..."),
                          SizedBox(width: 10),
                          CircularProgressIndicator(),
                        ],
                      )),
                    ),
                  )
                : state.status == BegginStatus.success
                    ? Container()
                    : const BegginProcessController(),
          );
        },
      ),
    );
  }
}
