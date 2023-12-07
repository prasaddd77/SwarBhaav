import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/custom_navigation_drawer.dart';
import '../home/home_screen.dart';

class StatsScreen extends StatefulWidget {
  static String routeName = "/stats";
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<_CallData>? _callData;
  List<_ChatData>? _chatData;

  @override
  void initState() {
    _callData = <_CallData>[
      _CallData(1, 324),
      _CallData(2, 450),
      _CallData(3, 563),
      _CallData(4, 650),
      _CallData(5, 494),
    ];

    _chatData = <_ChatData>[
      _ChatData("Happy", 30, Colors.green),
      _ChatData("Disappointed", 10, Colors.orange),
      _ChatData("Not satisfied", 20, Colors.yellow),
      _ChatData("Angry", 20, Colors.red),
      _ChatData("Afraid", 10, Colors.blue),
      _ChatData("Hysterical", 10, Colors.purple)
    ];

    super.initState();
  }

  @override
  void dispose() {
    _callData!.clear();
    _chatData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(
          "Statistics",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 12,
                child: Container(
                  // height: 400,
                  // width: 400,
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: _buildDefaultCircularChart(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 12,
                child: Container(
                  child: _buildDefaultLineChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SfCircularChart _buildDefaultCircularChart() {
    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: TextStyle(fontSize: 14, color: Colors.black),
      ),
      title: ChartTitle(
          text: 'Sentiment Score of All Chats Analyzed',
          alignment: ChartAlignment.center),
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

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: "Sentiment Score of Last Call Analyzed"),
      legend: const Legend(
          position: LegendPosition.top,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: TextStyle(fontSize: 12, color: Colors.black)),
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 1,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: 300,
        maximum: 700,
        labelFormat: '{value}',
        interval: 50,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_CallData, num>> _getDefaultLineSeries() {
    return <LineSeries<_CallData, num>>[
      LineSeries<_CallData, num>(
          animationDuration: 2500,
          dataSource: _callData!,
          xValueMapper: (_CallData sales, _) => sales.x,
          yValueMapper: (_CallData sales, _) => sales.y,
          width: 2,
          name: 'Hourly Call Sentiment Score',
          markerSettings: const MarkerSettings(isVisible: true)),
      // LineSeries<_ChartData, num>(
      //     animationDuration: 2500,
      //     dataSource: chartData!,
      //     width: 2,
      //     name: 'England',
      //     xValueMapper: (_CallData sales, _) => sales.x,
      //     yValueMapper: (_CallData sales, _) => sales.y2,
      //     markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}

class _CallData {
  _CallData(this.x, this.y);
  final double x;
  final double y;
}

class _ChatData {
  _ChatData(this.sentiment, this.value, this.color);
  final String sentiment;
  final double value;
  final Color color;
}
