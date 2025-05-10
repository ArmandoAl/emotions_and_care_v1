import '../helpers/paths.dart';

Widget testItem(BuildContext context, HistoryTestModel test,
    Function(TestInfoModel) onTap) {
  return Container(
    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.25,
    child: Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  startFrom(test.name, "("),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "Últimos resultados",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                test.testInfoList.length > 5 ? 5 : test.testInfoList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onTap(test.testInfoList[index]);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: testHistoryColors[
                            test.testInfoList[index].resultado],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(test.testInfoList[index].resultado,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "${test.testInfoList[index].date.day}/${test.testInfoList[index].date.month}/${test.testInfoList[index].date.year}",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: 5,
                          decoration: BoxDecoration(
                            color: testHistoryColors[
                                test.testInfoList[index].resultado],
                            borderRadius: BorderRadius.circular(15),
                          )),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
