import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/data/Server/network_service.dart';
import 'package:nextech_app/data/models/model_exports.dart';
import 'package:intl/intl.dart';
import '../../storage/hive_local_storage.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionHistoryScreenState();
  }
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool isPolling = false;
  List<TransactionModel> transactions = HiveStorage.getAllDocUploadHistory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          _headerText(),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          _historyCards(),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          pollButton(),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          const Text("Newest Uploads",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200)),
          uploadList(),
        ],
      ),
    );
  }

  Widget _headerText() {
    return Text("Upload History",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w400,
          letterSpacing: 4,
          color: kTitle,
        ));
  }

  Widget uploadList() {
    return Material(
      child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width*0.95,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
          ),
          shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Neumorphic(
                padding: const EdgeInsets.all(5),
                style: NeumorphicStyle(
                  color: transactions[index].status == DocStatus.yellow
                      ? kLightYellow2
                      : transactions[index].status == DocStatus.green
                          ? kLightGreen2
                          : kLightRed2,
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
                  depth: 8,
                  intensity: 0.65,
                  lightSource: LightSource.topLeft,
                  shadowDarkColor: Colors.black,
                  shadowLightColor: Colors.white,
                ),
                child: Container(
                  
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transactions[index].docName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                            ),
                          ),

                          Icon(size: 28,transactions[index].status == DocStatus.yellow
                              ? Icons.pending
                              : transactions[index].status == DocStatus.green
                                  ? Icons.check
                                  : Icons.close),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        "Uploaded At: ${DateFormat.Hm().format(DateTime.parse(transactions[index].timestamp))}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget pollButton() {
    return isPolling
        ? const CircularProgressIndicator()
        : NeumorphicButton(
            onPressed: () async {
              for (final tm in HiveStorage.getAllYellowTransactions()) {
                await NetworkService.pollDB(tm.tid);
              }
              setState(() {});
            },
            style: NeumorphicStyle(
              color: kPurpleColour,
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            ),
            child: Text(
              "Refresh",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kWhite,
              ),
            ),
          );
  }

  Widget _historyCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Neumorphic(
            padding: const EdgeInsets.all(30),
            style: NeumorphicStyle(
              color: kLightGreen,
              depth: 14,
              intensity: 0.65,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
            ),
            child: Column(
              children: [
                const Text("Uploaded"),
                Text(
                  "${HiveStorage.historyNums()[0]}",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            )),
        Neumorphic(
            padding: const EdgeInsets.all(30),
            style: NeumorphicStyle(
              color: kLightYellow,
              depth: 14,
              intensity: 0.65,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
            ),
            child: Column(
              children: [
                const Text("Pending"),
                Text(
                  "${HiveStorage.historyNums()[1]}",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            )),
        Neumorphic(
            padding: const EdgeInsets.all(30),
            style: NeumorphicStyle(
              color: kLightRed,
              depth: 14,
              intensity: 0.65,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
            ),
            child: Column(
              children: [
                const Text(" Failed "),
                Text(
                  "${HiveStorage.historyNums()[2]}",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            )),
      ],
    );
  }
}
