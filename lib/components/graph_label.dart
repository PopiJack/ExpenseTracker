import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';

class GraphLabel extends StatefulWidget {
  const GraphLabel(
      {super.key,
      required this.amount,
      required this.category,
      required this.percentValue,
      required this.color});

  final double amount;
  final Category category;
  final double percentValue;
  final Color color;

  @override
  State<GraphLabel> createState() => _GraphLabelState();
}

class _GraphLabelState extends State<GraphLabel> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 239, 239),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${widget.amount.toStringAsFixed(2)}'),
                Text('${widget.percentValue.toStringAsFixed(2)}%'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.category.name),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.color),
                  child: Center(
                    child: Icon(categoryIcons[widget.category], color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
