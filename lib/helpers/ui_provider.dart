import 'package:emotions_and_care_v1/helpers/paths.dart';

import '../config/assets/assets.dart';

class UIProvider extends ChangeNotifier {
  final StorageRepository _storageRepository;
  final UIRepositoryImpl _uiRepoitory;

  UIProvider({
    required StorageRepository storageRepository,
    required UIRepositoryImpl uiRepoitory,
  })  : _storageRepository = storageRepository,
        _uiRepoitory = uiRepoitory;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  FlowerModel? _currentFlower;
  FlowerModel? get currentFlower => _currentFlower;

  List<FlowerModel> _flowers = [];
  List<FlowerModel> get flowers => _flowers;

  List<StickerModel> _stickers = [];
  List<StickerModel> get stickers => _stickers;

  String? _selectedBackground = "null";
  String? get selectedBackground => _selectedBackground;

  int? selectedTheme = 0;

  List<ThemeData> themes = [
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
      scaffoldBackgroundColor: const Color.fromARGB(255, 242, 211, 247),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 242, 211, 247),
      ),
    ),
    //dark theme
    ThemeData(
      primaryColor: Colors.blue,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.blue,
        secondary: Colors.green,
        surface: Colors.grey[900],
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[800],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
    ),
  ];

  ThemeData get theme => themes[selectedTheme ?? 0];

  List<StickerModel> _stickersInUse = [
    StickerModel(),
    StickerModel(),
    StickerModel(),
    StickerModel(),
  ];
  List<StickerModel> get stickersInUse => _stickersInUse;

  void setUpUI() async {
    selectedTheme = await _storageRepository.getSelectedTheme();

    selectedTheme ??= 0;

    _currentFlower = await _storageRepository.getCurrentFlower();

    _flowers = await _storageRepository.getFlowers();

    _selectedBackground = await _storageRepository.getSelectedBackground();

    _selectedBackground ??= "null";

    if (flowers.isEmpty) {
      _flowers = [
        FlowerModel(
            id: 1,
            urls: [Assets.plant, Assets.flower],
            state: FlowerState.initialFlowet),
      ];
    }

    _stickers = await _storageRepository.getStickers();

    _stickersInUse = await _storageRepository.getStickersInUse();

    if (stickersInUse.length < 4) {
      _stickersInUse = List.generate(4, (index) => StickerModel.empty());
    }

    notifyListeners();
  }

  void setTheme(int index) {
    selectedTheme = index;
    _storageRepository.saveSelectedTheme(index);
    notifyListeners();
  }

  void setSelectedBackground(String background) {
    _selectedBackground = background;
    _storageRepository.saveSelectedBackground(background);
    notifyListeners();
  }

  void setCurrentFlower(FlowerModel flower) {
    _currentFlower = flower;
    _storageRepository.saveCurrentFlower(flower);
    notifyListeners();
  }

  void addFlower(FlowerModel flower) {
    _flowers.add(flower);
    _storageRepository.saveFlowers(_flowers);

    notifyListeners();
  }

  void setStickerInUse(StickerModel sticker, int index) {
    _stickersInUse[index] = sticker;
    _storageRepository.saveStickersInUse(_stickersInUse);
    notifyListeners();
  }

  void addSticker(StickerModel sticker) {
    _stickers.add(sticker);
    _storageRepository.saveStickers(_stickers);

    notifyListeners();
  }

  void setStickers(List<StickerModel> stickers) {
    _stickers = stickers;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Future<void> getSticker(int id) async {
    final sticker = await _uiRepoitory.getSticker(id);
    _stickers.add(sticker);
    _storageRepository.saveStickers(_stickers);
    notifyListeners();
  }

  void logout(BuildContext context) async {
    await _storageRepository.clean();
    _currentFlower = null;
    _flowers = [];
    _stickers = [];
    _stickersInUse = [];
    _selectedBackground = "null";
    selectedTheme = 0;
    notifyListeners();
  }
}
