import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/boxed_container.dart';
import '../components/custom_navigation_drawer.dart';

class HistoryScreen extends StatefulWidget {
  final BuildContext? context;
  static String routeName = "/history";
  const HistoryScreen({super.key, this.context});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<_ChatData>? _chatData;
  Map<String, dynamic>? jsonData;

  Future<void> loadData() async {
    String jsonString =
        await rootBundle.loadString("assets/data/response.json");
    jsonData = json.decode(jsonString);
  }

  double parsePercentage(String? percentage) {
    if (percentage == null) {
      return 0.0;
    }
    return double.tryParse(percentage.replaceAll('%', '')) ?? 0.0;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 225, 233, 249),
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(
          "Analysis History",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: const [
                BoxedContainer(
                    title: "Calls Analyzed",
                    val: 10,
                    icon: Icons.call_outlined),
                BoxedContainer(
                    title: "Chats Analyzed",
                    val: 20,
                    icon: Icons.chat_outlined),
                BoxedContainer(
                    title: "Reports Generated",
                    val: 30,
                    icon: Icons.description_outlined),
              ],
            ),
            const SizedBox(height: 20),
            DataTable(
              columnSpacing: 10,
              columns: buildColumns,
              rows: buildRows,
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> get buildColumns {
    return const <DataColumn>[
      DataColumn(
        label: Text(
          "DATE",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          "TIME",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          "SENTIMENT\nTYPE",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          "RESULT",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ];
  }

  List<DataRow> get buildRows {
    return <DataRow>[
      generateSingleRow(
        color: Colors.white54,
        date: "11/01/2023",
        time: "11:00",
        type: "Audio",
      ),
      generateSingleRow(
        color: Colors.blue[100]!,
        date: "17/01/2023",
        time: "04:45",
        type: "Chat",
      ),
      generateSingleRow(
        color: Colors.white54,
        date: "18/01/2023",
        time: "07:00",
        type: "Audio",
      ),
      generateSingleRow(
        color: Colors.blue[100]!,
        date: "23/01/2023",
        time: "12:15",
        type: "Chat",
      ),
    ];
  }

  SfCircularChart _buildDefaultCircularChart() {
    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: TextStyle(fontSize: 14, color: Colors.black),
      ),
      title:
          ChartTitle(text: 'Sentiment Score', alignment: ChartAlignment.center),
      series: _getDefaultPieSeries(),
    );
  }

  List<CircularSeries<dynamic, dynamic>> _getDefaultPieSeries() {
    return <CircularSeries>[
      PieSeries<_ChatData, String>(
        dataSource: _chatData,
        xValueMapper: (_ChatData data, _) => data.sentiment,
        yValueMapper: (_ChatData data, _) => data.value,
        pointColorMapper: (_ChatData data, _) => data.color,
        dataLabelMapper: (_ChatData data, _) => data.sentiment,
        radius: "100%",
      ),
    ];
  }

  DataRow generateSingleRow({
    required Color color,
    required String date,
    required String time,
    required String type,
    Function? onPressed,
  }) {
    return DataRow(
      color: MaterialStateProperty.all(color),
      cells: <DataCell>[
        DataCell(
          Text(date, style: const TextStyle(color: Colors.black, fontSize: 15)),
        ),
        DataCell(
          Text(time, style: const TextStyle(color: Colors.black, fontSize: 15)),
        ),
        DataCell(Container(
          width: 70,
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 35, 143, 189),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(type,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 2, 28, 52)))),
        )),
        DataCell(
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.white,
              shadowColor: Colors.blue,
            ),
            onPressed: () {
              if (type == "Audio")
                generateDialogBox();
              else if (type == "Chat") showDialogBox();
            },
            child: const Text(
              "View Result",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  final _callData = ["happy☺", "angry😡", "disgust 😫", "sad ☹"];

  generateDialogBox() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Call Sentiment Analysis",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                              child: Text(
                                "Classified Audio Sentiment:",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "happy☺",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<dynamic> showDialogBox() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Dialog(
            elevation: 10,
            child: Column(
              children: [
                FutureBuilder<void>(
                  future: loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String? positivePercentage =
                          jsonData?['sentiment_scores']?['positive'];
                      String? negativePercentage =
                          jsonData?['sentiment_scores']?['negative'];
                      String? neutralPercentage =
                          jsonData?['sentiment_scores']?['neutral'];

                      double positiveScore =
                          parsePercentage(positivePercentage);
                      double negativeScore =
                          parsePercentage(negativePercentage);
                      double neutralScore = parsePercentage(neutralPercentage);

                      _chatData = <_ChatData>[
                        _ChatData("Positive", positiveScore, Colors.green),
                        _ChatData("Negative", negativeScore, Colors.red),
                        _ChatData("Neutral", neutralScore, Colors.yellow),
                      ];
                      return _buildDefaultCircularChart();
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Chat Summary",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    jsonData?['openai_response'] ?? "Loading...",
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "Key Words",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListOfResults(
                          jsonData: jsonData,
                          category: "positive_words",
                          title: "Positives",
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListOfResults(
                          jsonData: jsonData,
                          category: "negative_words",
                          title: "Negatives",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListOfResults extends StatelessWidget {
  final String category;
  final String title;

  const ListOfResults({
    super.key,
    required this.jsonData,
    required this.category,
    required this.title,
  });

  final Map<String, dynamic>? jsonData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(jsonData?[category][index] ?? "Loading...",
                  style: const TextStyle(color: Colors.black)),
            );
          },
          itemCount: (jsonData?[category] as List).length,
        ),
      ],
    );
  }
}

class _ChatData {
  _ChatData(this.sentiment, this.value, this.color);
  final String sentiment;
  final double value;
  final Color color;
}
