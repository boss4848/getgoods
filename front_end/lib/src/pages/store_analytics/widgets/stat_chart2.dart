import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:intl/intl.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.amber,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.55,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 25),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        const SizedBox(
          height: defaultpadding / 2,
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  showAvg ? Colors.amber : primaryColor),
              shadowColor: const MaterialStatePropertyAll(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              showAvg ? 'Range 0-3K' : 'Range 0-5K',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
                color: showAvg ? Colors.brown : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime currentDate = DateTime.now();
    String dateCurrent = DateFormat.E().format(currentDate);

    DateTime previousDate = currentDate.subtract(Duration(days: 1));
    String datePrevious = DateFormat.E().format(previousDate);

    DateTime previous2Date = currentDate.subtract(Duration(days: 2));
    String date2Previous = DateFormat.E().format(previous2Date);

    DateTime previous3Date = currentDate.subtract(Duration(days: 3));
    String date3Previous = DateFormat.E().format(previous3Date);

    DateTime previous4Date = currentDate.subtract(Duration(days: 4));
    String date4Previous = DateFormat.E().format(previous4Date);

    DateTime previous5Date = currentDate.subtract(Duration(days: 5));
    String date5Previous = DateFormat.E().format(previous5Date);

    DateTime previous6Date = currentDate.subtract(Duration(days: 6));
    String date6Previous = DateFormat.E().format(previous6Date);

    DateTime previous7Date = currentDate.subtract(Duration(days: 7));
    String date7Previous = DateFormat.E().format(previous7Date);
    //DateTime previousDay = currentDate.subtract(Duration(days: 1));

    const style = TextStyle(
        color: primaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFTHONBURI');
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(date6Previous, style: style);
        break;
      case 2:
        text = Text(date5Previous, style: style);
        break;
      case 4:
        text = Text(date4Previous, style: style);
        break;
      case 6:
        text = Text(date3Previous, style: style);
        break;
      case 8:
        text = Text(date2Previous, style: style);
        break;
      case 10:
        text = Text(datePrevious, style: style);
        break;
      case 12:
        text = Text(dateCurrent, style: style);
        //text = const Text('SUN', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: primaryTextColor,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      fontFamily: 'SFTHONBURI',
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'Revenue(Bath)',
          style: style,
        );
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        color: primaryTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'SFTHONBURI');
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 2:
        text = '1K';
        break;
      case 4:
        text = '2K';
        break;
      case 6:
        text = '3K';
        break;
      case 8:
        text = '4K';
        break;
      case 10:
        text = '5K';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: primaryColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: primaryColor.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: secondaryColor, width: 2.0),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2, 2),
            FlSpot(4, 5),
            FlSpot(6, 3.1),
            FlSpot(8, 4),
            FlSpot(10, 3),
            FlSpot(12, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.brown.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.brown.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: topTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.brown, width: 2.0),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 3.44),
            FlSpot(4, 3.44),
            FlSpot(6, 3.44),
            FlSpot(8, 3.44),
            FlSpot(10, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
