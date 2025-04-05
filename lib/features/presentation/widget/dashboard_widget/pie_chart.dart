import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatefulWidget {
  @override
  _ExpensePieChartState createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final double radius = 40;

    return SizedBox(
      width: 250,
      height: 250,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (event, response) {
              setState(() {
                if (!event.isInterestedForInteractions || response == null || response.touchedSection == null) {
                  touchedIndex = -1;
                } else {
                  touchedIndex = response.touchedSection!.touchedSectionIndex;
                  print(touchedIndex);
                }
              });
            },
          ),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: List.generate(3, (i) {
            final isTouched = i == touchedIndex;
            final double showRadius = isTouched ? 50 : radius;
            final labelColor = Theme.of(context).scaffoldBackgroundColor;

            switch (i) {
              case 0:
                return PieChartSectionData(
                  color: Colors.blue,
                  value: 40,
                  title: isTouched ? 'Transport\n40%' : '40%',
                  radius: showRadius,
                  titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor),
                );
              case 1:
                return PieChartSectionData(
                  color: Colors.green,
                  value: 35,
                  title: isTouched ? 'Food\n35%' : '35%',
                  radius: showRadius,
                  titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor),
                );
              case 2:
                return PieChartSectionData(
                  color: Colors.orange,
                  value: 10,
                  title: isTouched ? 'Bills\n10%' : '10%',
                  radius: showRadius,
                  titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: labelColor),
                );
              default:
                return throw Error();
            }
          }),
        ),
      ),
    );
  }
}
