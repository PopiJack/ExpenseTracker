import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custom_pie_chart.dart';
import 'package:flutter_application_2/components/graph_label.dart';
import 'package:flutter_application_2/models/expense.dart';
import 'package:flutter_application_2/models/list_of_expenses.dart';

class InsigthPage extends StatefulWidget {
  const InsigthPage({super.key, required this.transactionList});

  final ListOfTransactions transactionList;

  @override
  State<InsigthPage> createState() => _InsigthPageState();
}

class _InsigthPageState extends State<InsigthPage> {
  int touchedIndex = -1;
  DateTime? selectedTimeFrame = FilteredDates["Week"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomPieChart(
              transactionList: widget.transactionList,
              selectedTimeFrame: selectedTimeFrame!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: () {
                  setState(() {
                    selectedTimeFrame = FilteredDates["Week"];
                  });
                }, child:  Text('Week', style: TextStyle(color: selectedTimeFrame == FilteredDates['Week'] ? Colors.black : const Color.fromARGB(255, 150, 150, 150)),),),
                TextButton(onPressed: () {
                  setState(() {
                    selectedTimeFrame = FilteredDates["Month"];
                  });
                }, child: Text('Month',style: TextStyle(color: selectedTimeFrame == FilteredDates['Month'] ? Colors.black : const Color.fromARGB(255, 150, 150, 150)),)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTimeFrame = FilteredDates["Year"];
                    });
                  },
                  child: Text('Year', style: TextStyle(color: selectedTimeFrame == FilteredDates['Year'] ? Colors.black : const Color.fromARGB(255, 150, 150, 150)),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('Spending categories')],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GraphLabel(
                    amount: widget.transactionList
                        .getAmountForCategory(Category.values[0], selectedTimeFrame!),
                    category: Category.values[0],
                    percentValue: widget.transactionList
                        .getPercentForCategory(Category.values[0], selectedTimeFrame!),
                    color: Colors.red),
                SizedBox(
                  width: 10,
                ),
                GraphLabel(
                    amount: widget.transactionList
                        .getAmountForCategory(Category.values[1], selectedTimeFrame!),
                    category: Category.values[1],
                    percentValue: widget.transactionList
                        .getPercentForCategory(Category.values[1], selectedTimeFrame!),
                    color: Colors.blue),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GraphLabel(
                    amount: widget.transactionList
                        .getAmountForCategory(Category.values[2], selectedTimeFrame!),
                    category: Category.values[2],
                    percentValue: widget.transactionList
                        .getPercentForCategory(Category.values[2], selectedTimeFrame!),
                    color: Colors.green),
                SizedBox(
                  width: 10,
                ),
                GraphLabel(
                    amount: widget.transactionList
                        .getAmountForCategory(Category.values[3], selectedTimeFrame!),
                    category: Category.values[3],
                    percentValue: widget.transactionList
                        .getPercentForCategory(Category.values[3], selectedTimeFrame!),
                    color: Colors.yellow),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
