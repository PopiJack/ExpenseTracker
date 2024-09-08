import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/available_card.dart';
import 'package:flutter_application_2/components/custom_app_bar.dart';
import 'package:flutter_application_2/expenses_list.dart';
import 'package:flutter_application_2/models/expense.dart';
import 'package:flutter_application_2/models/list_of_expenses.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.transactionList});

  final ListOfTransactions transactionList;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;
  double _availableOnCard = 1000;
  final double _limit = 200;


  @override
  void initState() {
    for (Transaction expense in widget.transactionList.listOftransactions) {
      if (expense.typeOfTransaction == TypeOfTransaction.Outcome) {
        _counter += expense.amount;
        _availableOnCard -= expense.amount;
      } else {
        _availableOnCard += expense.amount;
      }
    }
    super.initState();
  }

  void _incrementCounter(double amount) {
    setState(() {
      _counter += amount;
      _availableOnCard -= amount;
    });
  }

  void _decrementCounter(double amount) {
    setState(() {
      _availableOnCard += amount;
    });
  }

  void _addNewExpense(Transaction expense) {
    setState(() {
      widget.transactionList.addTransaction(expense);
      if (expense.typeOfTransaction == TypeOfTransaction.Outcome) {
        _incrementCounter(expense.amount);
      } else {
        _decrementCounter(expense.amount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AvailableCard(
              limit: _limit,
              availableOnCard: _availableOnCard,
              amountSpent: _counter,
              onAddPayment: (expense) => _addNewExpense(expense),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
              ],
            ),
            Expanded(child: ExpenseList(listOfExpenses: widget.transactionList.listOftransactions)),
          ],
        ),
      ),
    );
  }
}
