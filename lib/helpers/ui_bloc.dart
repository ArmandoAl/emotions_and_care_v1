import 'package:emotions_and_care_v1/config/assets/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    FlowerModel? currentFlower = await storageRepository.getCurrentFlower();

    List<FlowerModel> flowers = await storageRepository.getFlowers();

    List<StickerModel> stickers = await storageRepository.getStickers();

    String? selectedBackground =
        await storageRepository.getSelectedBackground();

    selectedBackground ??= "null";

    if (flowers.isEmpty) {
      flowers = [
        FlowerModel(
          id: 1,
          urls: [Assets.plant, Assets.flower],
          state: FlowerState.initialFlowet,
        ),
      ];
    }

    emit(state.copyWith(
      isDarkMode: false,
      currentFlower: currentFlower,
      flowers: flowers,
      stickers: stickers,
      selectedBackground: selectedBackground,
      selectedTheme: selectedTheme,
    ));
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

  void setCurrentFlower(FlowerModel flower) {
    storageRepository.saveCurrentFlower(flower);
    emit(state.copyWith(currentFlower: flower));
  }

  void addFlower(FlowerModel flower) {
    final List<FlowerModel> flowers = state.flowers;
    flowers.add(flower);
    storageRepository.saveFlowers(flowers);
    emit(state.copyWith(flowers: flowers));
  }

  void setStickerInUse(StickerModel sticker, int index) {
    List<StickerModel>? stickersInUse = state.stickersInUse;

    stickersInUse ??= List.generate(4, (index) => StickerModel.empty());

    stickersInUse[index] = sticker;
    storageRepository.saveStickersInUse(stickersInUse);
    emit(state.copyWith(stickersInUse: stickersInUse));
  }

  void addSticker(StickerModel sticker) {
    final List<StickerModel> stickers = state.stickers;
    stickers.add(sticker);
    storageRepository.saveStickers(stickers);
    emit(state.copyWith(stickers: stickers));
  }

  void setStickers(List<StickerModel> stickers) {
    storageRepository.saveStickers(stickers);
    emit(state.copyWith(stickers: stickers));
  }

  void toggleTheme() {
    final bool isDarkMode = !state.isDarkMode;
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> getSticker(int id) async {
    final StickerModel sticker = await uiRepoitory.getSticker(id);
    final List<StickerModel> stickers = state.stickers;
    stickers.add(sticker);
    storageRepository.saveStickers(stickers);
    emit(state.copyWith(stickers: stickers));
  }

  Future<void> clean() async {
    await storageRepository.clean();
    emit(const UIState());
  }
}

enum UIStatus { start, login, register, loading, error }

class UIState extends Equatable {
  final UIStatus status;
  final bool isDarkMode;
  final FlowerModel? currentFlower;
  final List<FlowerModel> flowers;
  final List<StickerModel> stickers;
  final String selectedBackground;
  final int selectedTheme;
  final List<ThemeData>? themes;
  final List<StickerModel>? stickersInUse;

  const UIState(
      {this.status = UIStatus.start,
      this.isDarkMode = false,
      this.currentFlower,
      this.flowers = const [],
      this.stickers = const [],
      this.selectedBackground = "null",
      this.selectedTheme = 0,
      this.themes,
      this.stickersInUse});

  UIState copyWith({
    UIStatus? status,
    bool? isDarkMode,
    FlowerModel? currentFlower,
    List<FlowerModel>? flowers,
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
      stickersInUse: stickersInUse ?? this.stickersInUse,
    );
  }

  @override
  List<Object> get props => [
        status,
        isDarkMode,
        currentFlower ?? FlowerModel(),
        flowers,
        stickers,
        selectedBackground,
        selectedTheme,
        themes ??
            [
              ThemeData(
                useMaterial3: true,
                primaryColor: Colors.blue,
                colorScheme: const ColorScheme.light(
                    primary: Colors.blue,
                    secondary: Colors.blueAccent,
                    surface: Colors.blueGrey),
                scaffoldBackgroundColor: const Color(0xFFE3EDF3),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFE3EDF3),
                ),
              ),
              ThemeData(
                useMaterial3: true,
                primaryColor: const Color(0xff005954),
                colorScheme: const ColorScheme.light(
                    primary: Color(0xff005954),
                    secondary: Color(0xff9ce0db),
                    surface: Color(0xff338b85)),
                scaffoldBackgroundColor: const Color(0xffd5ffff),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xffd5ffff),
                ),
              ),
              ThemeData(
                useMaterial3: true,
                primaryColor: Colors.purple,
                colorScheme: const ColorScheme.light(
                    primary: Colors.purple,
                    secondary: Colors.purpleAccent,
                    surface: Colors.purpleAccent),
                scaffoldBackgroundColor: const Color(0xFFE3EDF3),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFE3EDF3),
                ),
              ),
            ],
        stickersInUse ??
            [
              StickerModel(),
              StickerModel(),
              StickerModel(),
              StickerModel(),
            ],
      ];
}
