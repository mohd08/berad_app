// ignore_for_file: camel_case_types, no_logic_in_create_state, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class chartBuilder extends StatefulWidget {
  chartBuilder({required this.priceTime, Key? key}) : super(key: key);
  List<dynamic> priceTime = [];
  

  @override
  _chartBuilderState createState() => _chartBuilderState(priceTime);
}

class _chartBuilderState extends State<chartBuilder> {
  _chartBuilderState(this.priceTime);
  List<dynamic> priceTime = [];
  @override
  Widget build(BuildContext context) {
    return
SfCartesianChart(
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
            );
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