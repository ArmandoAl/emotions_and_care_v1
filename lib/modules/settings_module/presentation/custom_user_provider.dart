import '../../../config/assets/assets.dart';
import '../../../helpers/paths.dart';

enum ItemUiType { colores, fondo, jardin, flores }

class CustomMenuScreen extends StatefulWidget {
  final BegginCubit userProvider;
  final UICubit uiProvider;
  const CustomMenuScreen(
      {super.key, required this.userProvider, required this.uiProvider});

  @override
  State<CustomMenuScreen> createState() => _CustomMenuScreenState();
}

class _CustomMenuScreenState extends State<CustomMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalización'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            listItemCustom(
              context,
              "Paleta de colores",
              const AssetImage(
                Assets.colorPallete,
              ),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeUiItemScreen(
                      userProvider: widget.userProvider,
                      uiProvider: widget.uiProvider,
                      itemType: ItemUiType.colores,
                      items: [
                        widget.uiProvider.state.themes![0],
                        widget.uiProvider.state.themes![1],
                        widget.uiProvider.state.themes![2],
                        widget.uiProvider.state.themes![3],
                      ],
                      blocks: const [false, false, true, false],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            listItemCustom(
              context,
              "Fondo de pantalla",
              const AssetImage(Assets.backPickerIcon),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeUiItemScreen(
                      userProvider: widget.userProvider,
                      uiProvider: widget.uiProvider,
                      itemType: ItemUiType.fondo,
                      items: const [
                        Assets.backgroundstatic_1,
                        Assets.backgroundstatic_2,
                        Assets.backgroundstatic_3,
                        Assets.backgroundstatic_4
                      ],
                      blocks: const [false, true, false, false],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            listItemCustom(
              context,
              "Perzonalizar jardín",
              const AssetImage(
                Assets.patioIcon,
              ),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            plane: null,
                            tap: () {},
                            registerFlow: null,
                            customEnable: true,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget listItemCustom(
  BuildContext context,
  String title,
  AssetImage icon,
  Function onTap,
) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Image(
            image: icon,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
        ],
      ),
    ),
  );
}
