import 'package:equatable/equatable.dart';
import '../../helpers/paths.dart';

class UICubit extends Cubit<UIState> {
  final StorageRepository storageRepository;
  final UIRepositoryImpl uiRepoitory;

  UICubit({
    required this.storageRepository,
    required this.uiRepoitory,
  }) : super(const UIState());

  void setUpUI() async {
    int? selectedTheme = await storageRepository.getSelectedTheme();
    selectedTheme ??= 0;

    List<ThemeData> themes = [
      // 🌊 Tema Azul (Principal)
      ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue[50]!,
        colorScheme: const ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.blueGrey,
            surface: Color(0xFFE3EDF3),
            onSecondary: Colors.black,
            onPrimary: Colors.white,
            onSurface: Colors.black),
        scaffoldBackgroundColor: const Color(0xFFE3EDF3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE3EDF3),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFFE3EDF3),
          iconColor: Colors.black,
          surfaceTintColor: Colors.black,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFFE3EDF3),
          surfaceTintColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blueGrey,
            ),
            surfaceTintColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFFE3EDF3)),
            surfaceTintColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.blueGrey),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Gilroy',
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🌿 Tema Verde Agua
      ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xff005954),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff005954),
          secondary: Color(0xff9ce0db),
          surface: Color(0xff338b85),
        ),
        scaffoldBackgroundColor: const Color(0xffd5ffff),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffd5ffff),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xffd5ffff),
          iconColor: Colors.black,
          surfaceTintColor: Colors.black,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xffd5ffff),
          surfaceTintColor: Colors.black,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xffd5ffff)),
            surfaceTintColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xff9ce0db),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Gilroy',
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 💜 Tema Morado
      ThemeData(
        useMaterial3: true,
        primaryColor: Colors.purple,
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.purpleAccent,
          surface: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 242, 211, 247),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 242, 211, 247),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color.fromARGB(255, 242, 211, 247),
          iconColor: Colors.black,
          surfaceTintColor: Colors.black,
        ),
        drawerTheme:
            const DrawerThemeData(backgroundColor: Colors.purpleAccent),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromARGB(255, 242, 211, 247),
          surfaceTintColor: Colors.black,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(255, 242, 211, 247)),
            surfaceTintColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blueGrey,
            ),
            surfaceTintColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Gilroy',
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🌙 Tema Oscuro
      ThemeData(
        useMaterial3: true,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.greenAccent,
          surface: Colors.grey[900]!,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[900],
          iconColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[900],
          surfaceTintColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.grey),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Gilroy',
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];

    String? selectedBackground =
        await storageRepository.getSelectedBackground();

    selectedBackground ??= "null";

    emit(state.copyWith(
      isDarkMode: false,
      themes: themes,
      currentFlower: null,
      flowers: [UserFlower(userFlowerId: 0, flower: FlowerModel(), state: 0)],
      stickers: List.generate(4, (index) => StickerModel.empty()),
      stickersInUse: List.generate(4, (index) => StickerModel.empty()),
      selectedBackground: selectedBackground,
      selectedTheme: selectedTheme,
    ));
  }

  void setBackAssets(
      List<UserSticker>? userStickers, List<UserFlower>? userFlowers) {
    emit(state.copyWith(
      status: UIStatus.loading,
    ));
    if (userStickers == null) return;

    //crea una nueva lista de userSticerks con los stickers que si tienen posicion

    List<UserSticker> newStickersInUse =
        userStickers.where((element) => element.position != null).toList();

    //odena los userStickers por la posicion de menor a mayor
    newStickersInUse.sort((a, b) => a.position!.compareTo(b.position!));

    List<StickerModel> newStickerInUse = newStickersInUse
        .where((element) => element.position != null)
        .map((e) => e.sticker)
        .toList();

    //ordenalos por la posicion

    //si los nuevos estickers son menos de 4 , se rellenan con stickers vacios
    if (newStickerInUse.length < 4) {
      newStickerInUse.addAll(List.generate(
          4 - newStickerInUse.length, (index) => StickerModel.empty()));
    }

    //si las nuevas flores son menos de 4 , se rellenan con flores vacias

    //busca la flor que tenga la posicion 1, si no la encuentra, asignas null
    UserFlower? currentFlower =
        userFlowers!.firstWhere((element) => element.position == 2, orElse: () {
      return UserFlower(userFlowerId: -1, flower: FlowerModel(), state: 0);
    });

    emit(state.copyWith(
        stickers: userStickers.map((e) => e.sticker).toList(),
        stickersInUse: newStickerInUse,
        flowers: userFlowers,
        currentFlower: currentFlower.userFlowerId == -1 ? null : currentFlower,
        status: UIStatus.success));
  }

  void growFlowerStage() {
    //encuentra la flor que tenga la posicion 1
    UserFlower? currentFlower = state.currentFlower;

    if (currentFlower == null) {
      return;
    }

    currentFlower = currentFlower.copyWith(state: currentFlower.state + 1);

    List<UserFlower> flowers = state.flowers.map((e) {
      if (e.userFlowerId == currentFlower!.userFlowerId) {
        return currentFlower;
      }
      return e;
    }).toList();

    emit(state.copyWith(flowers: flowers, currentFlower: currentFlower));
  }

  void changeStatus(UIStatus status) {
    emit(state.copyWith(status: status));
  }

  void changeDarkMode(bool isDarkMode) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  void setTheme(int index) {
    storageRepository.saveSelectedTheme(index);
    emit(state.copyWith(selectedTheme: index));
  }

  void setSelectedBackground(String background) {
    storageRepository.saveSelectedBackground(background);
    emit(state.copyWith(selectedBackground: background));
  }

  void setCurrentFlower(UserFlower flower) {
    //storageRepository.saveCurrentFlower(flower);
    emit(state.copyWith(currentFlower: flower));
  }

  void addFlower(UserFlower flower) {
    final List<UserFlower> flowers = state.flowers;
    flowers.add(flower);
    emit(state.copyWith(flowers: flowers));
  }

  void setFlowerInInterface(int idpatient, UserFlower flower, int position) {
    // Primero emitimos el estado loading
    emit(state.copyWith(status: UIStatus.loading));

    List<UserFlower> flowers = state.flowers.map((e) {
      if (e.position == position) {
        return flower.copyWith(position: null);
      }
      return e;
    }).toList();

    //ahora que hicimos que la flor que ya tenia esa posicion la tuviera de nuevo en 0, debemos asignarle la posicion a la nueva flor

    // Emitimos el cambio antes de la llamada al repositorio
    emit(state.copyWith(
        currentFlower: flower, flowers: flowers, status: UIStatus.success));

    // Hacemos la llamada al repositorio después
    uiRepoitory.setFlowerInInterface(idpatient, flower, position + 1);
  }

  void setStickerInUse(int idpatient, StickerModel sticker, int index) {
    // Primero emitimos el estado loading
    emit(state.copyWith(status: UIStatus.loading));

    List<StickerModel> stickersInUse = List.from(state.stickersInUse);

    if (stickersInUse.contains(sticker)) {
      int existingIndex =
          stickersInUse.indexWhere((element) => element == sticker);
      stickersInUse[existingIndex] = StickerModel.empty();
      stickersInUse[index] = sticker;
    } else {
      stickersInUse[index] = sticker;
    }

    // Emitimos el cambio antes de la llamada al repositorio
    emit(
        state.copyWith(stickersInUse: stickersInUse, status: UIStatus.success));

    // Hacemos la llamada al repositorio después
    uiRepoitory.setStickerInInterface(idpatient, sticker, index + 1);
  }

  void addSticker(StickerModel sticker) {
    final List<StickerModel> stickers = state.stickers!;
    stickers.add(sticker);
    emit(state.copyWith(stickers: stickers));
  }

  void setStickers(List<StickerModel> stickers) {
    emit(state.copyWith(stickers: stickers));
  }

  void toggleTheme() {
    final bool isDarkMode = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> getSticker(int id) async {
    final StickerModel sticker = await uiRepoitory.getSticker(id);
    final List<StickerModel> stickers = state.stickers!;
    stickers.add(sticker);
    storageRepository.saveStickers(stickers);
    emit(state.copyWith(stickers: stickers));
  }

  Future<void> clean() async {
    emit(const UIState());
    setUpUI();
  }
}

enum UIStatus { start, login, register, loading, error, success }

class UIState extends Equatable {
  final UIStatus status;
  final bool isDarkMode;
  final UserFlower? currentFlower;
  final List<UserFlower> flowers;
  final List<StickerModel>? stickers;
  final String selectedBackground;
  final int selectedTheme;
  final List<ThemeData> themes;
  final List<StickerModel> stickersInUse; // Cambia para que no sea nullable

  const UIState({
    this.status = UIStatus.start,
    this.isDarkMode = false,
    this.currentFlower,
    this.flowers = const [],
    this.stickers = const [],
    this.selectedBackground = "null",
    this.selectedTheme = 0,
    this.themes = const [],
    this.stickersInUse = const [], // Inicialización por defecto
  });

  UIState copyWith({
    UIStatus? status,
    bool? isDarkMode,
    UserFlower? currentFlower,
    List<UserFlower>? flowers,
    List<StickerModel>? stickers,
    String? selectedBackground,
    int? selectedTheme,
    List<ThemeData>? themes,
    List<StickerModel>? stickersInUse,
  }) {
    return UIState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentFlower: currentFlower ?? this.currentFlower,
      flowers: flowers ?? this.flowers,
      stickers: stickers ?? this.stickers,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      themes: themes ?? this.themes,
      stickersInUse:
          stickersInUse ?? this.stickersInUse, // Siempre inicializado
    );
  }

  @override
  List<Object> get props => [
        status,
        isDarkMode,
        currentFlower ?? FlowerModel(),
        flowers,
        stickers ?? [],
        selectedBackground,
        selectedTheme,
        themes,
        stickersInUse, // No es nullable
      ];
}
