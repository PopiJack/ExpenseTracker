import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';
import 'package:flutter_application_2/models/list_of_expenses.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({super.key, required this.transactionList, required this.selectedTimeFrame});

  final ListOfTransactions transactionList;
  final DateTime selectedTimeFrame;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  Map<Category, double> _values = {
    Category.Food: 0,
    Category.Leisure: 0,
    Category.Travel: 0,
    Category.Work: 0,
  };
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize the values when the transaction list changes
    if (oldWidget.transactionList != widget.transactionList) {
      _values = {
        Category.Food: 0,
        Category.Leisure: 0,
        Category.Travel: 0,
        Category.Work: 0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(children: [
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 80,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Spent'),
            Text(widget.transactionList
                .getTotalAmount(widget.selectedTimeFrame)
                .toStringAsFixed(2)),
          ],
        )),
      ]),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(_values.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 20.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: widget.transactionList
                .getPercentForCategory(Category.Food, widget.selectedTimeFrame),
            title:
                '${widget.transactionList.getPercentForCategory(Category.Food, widget.selectedTimeFrame).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.transactionList.getPercentForCategory(
                Category.Leisure, widget.selectedTimeFrame),
            title:
                '${widget.transactionList.getPercentForCategory(Category.Leisure, widget.selectedTimeFrame).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow,
            value: widget.transactionList
                .getPercentForCategory(Category.Work, widget.selectedTimeFrame),
            title:
                '${widget.transactionList.getPercentForCategory(Category.Work, widget.selectedTimeFrame).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
value: widget.transactionList.getPercentForCategory(Category.Travel, widget.selectedTimeFrame),
            title:
                '${widget.transactionList.getPercentForCategory(Category.Travel, widget.selectedTimeFrame).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
