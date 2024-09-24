import 'package:emotions_and_care_v1/helpers/navigation_bloc.dart';
import 'package:emotions_and_care_v1/helpers/paths.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<NavigationBloc>(NavigationBloc(NavigationItem.home));

  // Storage
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  getIt.registerSingleton<UserRepository>(UserRepository());

  getIt.registerSingleton<UIRepositoryImpl>(UIRepositoryImpl());

  getIt.registerSingleton<UICubit>(UICubit(
      storageRepository: getIt<StorageRepository>(),
      uiRepoitory: getIt<UIRepositoryImpl>()));

  getIt.registerSingleton<BegginCubit>(BegginCubit(
    storageRepository: getIt<StorageRepository>(),
    userRepoitory: getIt<UserRepository>(),
  ));

  getIt.registerSingleton<CartRepository>(CartRepository());

  getIt.registerSingleton<CommunityCubit>(
      CommunityCubit(repository: getIt<CartRepository>()));

  getIt.registerSingleton<EmotionRepository>(EmotionRepository());

  getIt.registerSingleton<EmotionCubit>(EmotionCubit());

  getIt.registerSingleton<NotificationRepository>(NotificationRepository());

  getIt.registerSingleton<HomeCubit>(
      HomeCubit(repository: getIt<NotificationRepository>()));

  getIt.registerSingleton<SpecialistRepository>(SpecialistRepository());

  getIt.registerSingleton<PattientsCubit>(
      PattientsCubit(repository: getIt<SpecialistRepository>()));

  getIt.registerSingleton<NoteRepository>(NoteRepository());

  getIt.registerSingleton<DailyCubit>(
      DailyCubit(repository: getIt<NoteRepository>()));

  getIt.registerSingleton<ScheduleRepository>(ScheduleRepository());

  getIt.registerSingleton<ScheduleCubit>(ScheduleCubit(
    repository: getIt<ScheduleRepository>(),
  ));

  getIt.registerSingleton<TestRepository>(TestRepository());

  getIt.registerSingleton<TestCubit>(TestCubit(
    repository: getIt<TestRepository>(),
  ));
}
