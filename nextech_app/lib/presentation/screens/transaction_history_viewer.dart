import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nextech_app/constants/app_colours.dart';
import 'package:nextech_app/data/Server/network_service.dart';
import 'package:nextech_app/data/locator.dart';
import 'package:nextech_app/data/models/model_exports.dart';
import 'package:intl/intl.dart';
import '../../data/runtime_state.dart';
import '../../storage/hive_local_storage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransactionHistoryScreenState();
  }
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool isPolling = false;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  void initState() {
    runTimeState.get<AppRunTimeStatus>().initTranscations();
    if (runTimeState.get<AppRunTimeStatus>().rlt == reqListType.Red) {
      runTimeState.get<AppRunTimeStatus>().transactions =
          HiveStorage.getAllRedTransactions();
    } else if (runTimeState.get<AppRunTimeStatus>().rlt == reqListType.Green) {
      runTimeState.get<AppRunTimeStatus>().transactions =
          HiveStorage.getAllGreenTransactions();
    } else if (runTimeState.get<AppRunTimeStatus>().rlt == reqListType.Yellow) {
      runTimeState.get<AppRunTimeStatus>().transactions =
          HiveStorage.getAllYellowTransactions();
    }
    super.initState();
  }

  void setter(reqListType rlt) {
    runTimeState.get<AppRunTimeStatus>().rlt = rlt;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/background_4.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            _headerText(),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            _historyCards(context),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            pollButton(context),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            const Text("Newest Uploads",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400)),
            uploadList(),
          ],
        ),
      ),
    ]);
  }

  Widget _headerText() {
    return Text("Upload History",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          letterSpacing: 3,
          color: kTitle,
        ));
  }

  Widget uploadList() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width * 0.95,
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            itemCount:
                runTimeState.get<AppRunTimeStatus>().transactions.length > 10
                    ? 10
                    : runTimeState.get<AppRunTimeStatus>().transactions.length,
            itemBuilder: (context, index) {
              print("--" +
                  runTimeState
                      .get<AppRunTimeStatus>()
                      .transactions
                      .length
                      .toString());
              if (runTimeState.get<AppRunTimeStatus>().transactions.isEmpty) {
                print("empty");
                switch (runTimeState.get<AppRunTimeStatus>().rlt) {
                  case reqListType.Red:
                    return const Text("No Failed uploads yet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400));
                  case reqListType.Green:
                    return const Text("No Successful uploads yet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400));
                  case reqListType.Yellow:
                    return const Text("No Pending uploads yet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400));
                  default:
                    return const Text("No uploads yet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400));
                }
              }
              return Neumorphic(
                padding: const EdgeInsets.all(5),
                style: NeumorphicStyle(
                  color: runTimeState
                              .get<AppRunTimeStatus>()
                              .transactions[index]
                              .status ==
                          DocStatus.yellow
                      ? kLightYellow2
                      : runTimeState
                                  .get<AppRunTimeStatus>()
                                  .transactions[index]
                                  .status ==
                              DocStatus.green
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
                            runTimeState
                                .get<AppRunTimeStatus>()
                                .transactions[index]
                                .docName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Icon(
                              size: 28,
                              runTimeState
                                          .get<AppRunTimeStatus>()
                                          .transactions[index]
                                          .status ==
                                      DocStatus.yellow
                                  ? Icons.pending
                                  : runTimeState
                                              .get<AppRunTimeStatus>()
                                              .transactions[index]
                                              .status ==
                                          DocStatus.green
                                      ? Icons.check
                                      : Icons.close),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Column(
                        children: [
                          Text(
                              "Uploaded by : ${runTimeState.get<AppRunTimeStatus>().transactions[index].username}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                              )),
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Text(
                            "Uploaded At: ${DateFormat.Hm().format(DateTime.parse(runTimeState.get<AppRunTimeStatus>().transactions[index].timestamp))}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget pollButton(context) {
    DateTime selectedValue = DateTime.now();
    return isPolling
        ? const CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) => Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: SimpleDialog(
                                alignment: Alignment.center,
                                children: [
                                  SfDateRangePicker(
                                    allowViewNavigation: false,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      print(args.value.startDate.toString());
                                      print(args.value.startDate
                                          .toString()
                                          .split(" ")[0]);
                                      _selectedDate = DateFormat.yMd()
                                          .format(DateTime.parse(
                                              args.value.startDate.toString()))
                                          ;
                                      //print("selected date" + _selectedDate.toString());
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    initialSelectedRange: PickerDateRange(
                                        DateTime.now()
                                            .subtract(const Duration(days: 30)),
                                        DateTime.now()
                                            .add(const Duration(days: 0))),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      runTimeState
                                          .get<AppRunTimeStatus>()
                                          .setBetween(selectedValue);

                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text("Set Filter"),
                                  ),
                                ],
                              ),
                            ),
                          ));
                },
                child: const Text("Date Filter"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
              ),
              NeumorphicButton(
                onPressed: () async {
                  for (final tm in HiveStorage.getAllYellowTransactions()) {
                    await NetworkService.pollDB(tm.tid);
                  }
                  runTimeState.get<AppRunTimeStatus>()..initTranscations();
                  setState(() {});
                },
                style: NeumorphicStyle(
                  color: kPurpleColour,
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      "Refresh",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _historyCards(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print("Tapped");
            runTimeState
                .get<AppRunTimeStatus>()
                .setTransactionList(reqListType.Green);
            setter(
                runTimeState.get<AppRunTimeStatus>().rlt = reqListType.Green);
          },
          child: Neumorphic(
              padding: const EdgeInsets.all(30),
              style: NeumorphicStyle(
                color: kLightGreen,
                depth: 14,
                intensity: 0.65,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
              ),
              child: Column(
                children: [
                  const Text("Uploaded"),
                  Text(
                    "${HiveStorage.historyNums()[0]}",
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            print("Tapped");
            runTimeState
                .get<AppRunTimeStatus>()
                .setTransactionList(reqListType.Yellow);
            setter(
                runTimeState.get<AppRunTimeStatus>().rlt = reqListType.Yellow);
          },
          child: Neumorphic(
              padding: const EdgeInsets.all(30),
              style: NeumorphicStyle(
                color: kLightYellow,
                depth: 14,
                intensity: 0.65,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
              ),
              child: Column(
                children: [
                  const Text("Pending"),
                  Text(
                    "${HiveStorage.historyNums()[1]}",
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            runTimeState
                .get<AppRunTimeStatus>()
                .setTransactionList(reqListType.Red);
            setter(runTimeState.get<AppRunTimeStatus>().rlt = reqListType.Red);
          },
          child: Neumorphic(
              padding: const EdgeInsets.all(30),
              style: NeumorphicStyle(
                color: kLightRed,
                depth: 14,
                intensity: 0.65,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
              ),
              child: Column(
                children: [
                  const Text(" Failed "),
                  Text(
                    "${HiveStorage.historyNums()[2]}",
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
