import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key, required this.listOfExpenses});

  final List<Transaction> listOfExpenses;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listOfExpenses.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: const BorderSide(width: 1, color: Color.fromARGB(63, 0, 0, 0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24, // Adjust the size of the avatar as needed
                  backgroundColor: const Color.fromARGB(
                      255, 240, 239, 239), // Example background color
                  child: Icon(typeOfTransactionIcons[widget.listOfExpenses[index].typeOfTransaction]),
                ),
                const SizedBox(width: 16), // Space between avatar and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.listOfExpenses[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 8),
                          Text(widget.listOfExpenses[index].formattedDate),
                          const Spacer(), // Takes remaining space
                          Row(
                            children: [
                              Icon(widget.listOfExpenses[index].typeOfTransaction == TypeOfTransaction.Income ? Icons.add : Icons.remove, color: widget.listOfExpenses[index].typeOfTransaction == TypeOfTransaction.Income ? Colors.green : Colors.red,),
                              Text(
                                  '\$${widget.listOfExpenses[index].amount.toStringAsFixed(2)}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
