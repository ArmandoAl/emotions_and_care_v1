import 'package:emotions_and_care_v1/helpers/navigation_bloc.dart';
import 'package:emotions_and_care_v1/helpers/notifications_cubit.dart';
import 'package:emotions_and_care_v1/helpers/paths.dart';
import 'package:emotions_and_care_v1/modules/patients_request/presentation/logic/patient_request_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Registro asincrónico de SharedPreferences
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // Registro asincrónico de StorageRepository
  getIt.registerSingleton<StorageRepository>(StorageRepository(
    sharedPreferences: await getIt.getAsync<SharedPreferences>(),
  ));

  // Otros registros de objetos sincrónicos
  getIt.registerSingleton<NavigationBloc>(NavigationBloc(NavigationItem.home));

  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerSingleton<UIRepositoryImpl>(UIRepositoryImpl());

  // Usa `getIt<StorageRepository>()` sólo después de que se asegure su disponibilidad
  getIt.registerSingleton<UICubit>(UICubit(
    storageRepository: getIt<StorageRepository>(),
    uiRepoitory: getIt<UIRepositoryImpl>(),
  ));

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
  getIt.registerSingleton<ScheduleCubit>(
      ScheduleCubit(repository: getIt<ScheduleRepository>()));

  getIt.registerSingleton<TestRepository>(TestRepository());
  getIt.registerSingleton<TestCubit>(TestCubit(
    repository: getIt<TestRepository>(),
  ));

  //PattientsDatesCubit
  getIt.registerSingleton<PattientsDatesCubit>(PattientsDatesCubit(
    repository: getIt<ScheduleRepository>(),
  ));

  getIt.registerSingleton<PatientsRequestCubit>(PatientsRequestCubit(
    userRepository: getIt<UserRepository>(),
    specialistRepository: getIt<SpecialistRepository>(),
  ));

  getIt
      .registerSingleton<FirebaseNotificationsCubit>(FirebaseNotificationsCubit(
    begginCubit: getIt<BegginCubit>(),
    homeCubit: getIt<HomeCubit>(),
    patientsRequestCubit: getIt<PatientsRequestCubit>(),
  ));

  getIt<FirebaseNotificationsCubit>().initialize();

  // Espera a que las instancias asincrónicas estén listas antes de continuar
  await getIt.allReady();
}
