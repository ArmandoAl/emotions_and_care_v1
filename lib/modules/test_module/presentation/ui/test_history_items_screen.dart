import '../../../../helpers/paths.dart';

class TestHistoryItemsScreen extends StatefulWidget {
  final HistoryTestModel test;
  final Function(TestInfoModel) onTap;
  const TestHistoryItemsScreen(
      {super.key, required this.test, required this.onTap});

  @override
  State<TestHistoryItemsScreen> createState() => _TestHistoryItemsScreenState();
}

class _TestHistoryItemsScreenState extends State<TestHistoryItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: widget.test.name,
        isForReturn: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: widget.test.testInfoList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  testHistoryItem(
                    context,
                    widget.test.testInfoList[index],
                    widget.onTap,
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          )),
    );
  }
}

Widget testHistoryItem(
  BuildContext context,
  TestInfoModel testInfo,
  Function(TestInfoModel) onTap,
) {
  return GestureDetector(
    onTap: () {
      onTap(testInfo);
    },
    child: Container(
      decoration: BoxDecoration(
        color: testHistoryColors[testInfo.resultado],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(testInfo.resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${testInfo.date.day}/${testInfo.date.month}/${testInfo.date.year}",
              ),
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: MediaQuery.of(context).size.width * 0.03,
          )
        ],
      ),
    ),
  );
}
