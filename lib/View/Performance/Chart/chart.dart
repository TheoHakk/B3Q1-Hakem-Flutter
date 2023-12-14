import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  Chart({super.key});

  final Color dark = Colors.redAccent;
  final Color light = Colors.greenAccent;

  @override
  State<StatefulWidget> createState() => ChartState();
}

class Data {
  late String hour;
  late int value;

  Data(this.hour, this.value);

  String getHour() {
    return hour;
  }

  int getValue() {
    return value;
  }
}

class ChartState extends State<Chart> {
  int objectif = 10;

  List<Data> data = [
    Data("00:00", 5),
    Data("01:00", 14),
    Data("02:00", 6),
    Data("03:00", 18),
    Data("04:00", 20),
    Data("05:00", 15),
    Data("06:00", 6),
    Data("07:00", 25),
    Data("08:00", 3),
    Data("09:00", 18),
    Data("10:00", 15),
  ];

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    if (value.toInt() < data.length) {
      text = data[value.toInt()].getHour();
    } else {
      text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2.5,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: LayoutBuilder(builder: (context, constraints) {
            final barsSpace = 4.0 * constraints.maxWidth / 40;
            final barsWidth = 8.0 * constraints.maxWidth / 200;
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: bottomTitles,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    groupsSpace: barsSpace,
                    barGroups: getData(barsWidth, barsSpace, data),
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: objectif as double,
                          color: Colors.blueAccent,
                          strokeWidth: 2,
                          dashArray: [10, 5],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }

  List<BarChartGroupData> getData(
      double barsWidth, double barsSpace, List<Data> data) {
    return [
      //Foreach data, create a BarChartGroupData
      for (int i = 0; i < data.length; i++)
        BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              toY: data[i].getValue().toDouble(),
              rodStackItems: [
                BarChartRodStackItem(0, objectif as double, widget.dark),
                BarChartRodStackItem(objectif as double, 50000.0, widget.light),
              ],
              borderRadius: BorderRadius.zero,
              width: barsWidth,
            ),
          ],
        ),
    ];
  }
}
