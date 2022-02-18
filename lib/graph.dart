// ignore_for_file: avoid_print, unused_import, non_constant_identifier_names, camel_case_types, prefer_const_constructors, empty_constructor_bodies, no_logic_in_create_state, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'chart.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final channel = IOWebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=1089'));

  String symbolName = "Volatility 50 Index";
  List<tickHistory> priceTime = [];

  void getTickHistory() {
    String request = '{"ticks_history": "R_50" ,"count": 100,"end": "latest"}';
    channel.sink.add(request);
  }

  @override
  void initState() {
    getTickHistory();
    InitialTicks();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromRGBO(8, 217, 217, 100),
        title: Center(
          child: Text(
            symbolName,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: SfCartesianChart(
              margin: EdgeInsets.only(top: 20.0, left: 8.0),
              enableAxisAnimation: true,
              plotAreaBackgroundColor: Colors.black,

              zoomPanBehavior: ZoomPanBehavior(
                selectionRectColor: Colors.red,
                zoomMode: ZoomMode.x,
                enablePanning: true,
                enableDoubleTapZooming: true,
                enablePinching: true,
              ),
              primaryXAxis: CategoryAxis(
                isVisible: true,
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(color: Colors.white),
                labelPlacement: LabelPlacement.onTicks,
                labelPosition: ChartDataLabelPosition.inside,
              ),
              primaryYAxis: NumericAxis(
                interval: 0.1,
                majorGridLines: MajorGridLines(width: 0),
                labelPosition: ChartDataLabelPosition.inside,
                labelStyle: TextStyle(color: Colors.white),
                opposedPosition: true,
              ),

              // Chart title

              tooltipBehavior: TooltipBehavior(
                tooltipPosition: TooltipPosition.auto,
                color: Colors.red,
                elevation: 10,
                enable: true,
                format: 'point.y at point.x',
                shouldAlwaysShow: true,
                canShowMarker: true,
              ),
              series: <ChartSeries<tickHistory, String>>[
                LineSeries<tickHistory, String>(
                  color: Colors.grey,
                  enableTooltip: true,
                  dataSource: priceTime,
                  xValueMapper: (tickHistory ticks, _) => ticks.time,
                  yValueMapper: (tickHistory ticks, _) => ticks.price,
                  name: 'Ticks',
                  // Enable data label
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Icon(Icons.watch_later_outlined),
              ),
              Text(
                "Time Intervals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ToggleSwitch(
                fontSize: 11,
                iconSize: 8.0,
                minWidth: 60,
                inactiveBgColor: Colors.grey.shade400,
                activeFgColor: Colors.black,
                activeBgColor: [Colors.grey],
                initialLabelIndex: 0,
                totalSwitches: 4,
                labels: ['1 Day', '7 Day', '30 Days', '1 Year'],
                onToggle: (index) {
                  print('switched to: $index');
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void InitialTicks() {
    channel.stream.listen((data) {
      var price = jsonDecode(data);
      setState(() {
        List<dynamic> timeConverted = [];
        for (int i = 0; i <= price['history']['times'].length - 1; i++) {
          // Converts epoch to DateTimestamp format
          timeConverted.add(DateTime.fromMillisecondsSinceEpoch(
              price['history']['times'][i] * 1000));

          String extractedTime = DateFormat.Hms().format(timeConverted[i]);

          priceTime.add(
            tickHistory(
              time: extractedTime,
              price: price['history']['prices'][i],
            ),
          );
        }
      });
      channel.sink.close();
    });
  }
}

class tickHistory {
  final String time;
  final double price;

  tickHistory({
    required this.time,
    required this.price,
  });

  @override
  String toString() => '[ $time , $price ]';
}
