import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';
import 'package:flutter_application_2/screens/add_new_purchase.dart';

class AvailableCard extends StatefulWidget {
  const AvailableCard(
      {super.key,
      required this.availableOnCard,
      required this.limit,
      required this.amountSpent,
      required this.onAddPayment});

  final double availableOnCard;
  final double limit;
  final double amountSpent;
  final void Function(Transaction expense) onAddPayment;

  @override
  State<AvailableCard> createState() => __AvailableCardState();
}

class __AvailableCardState extends State<AvailableCard> {
  void _openExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: ((context) => AdditionalPurchase(onAddExpense: widget.onAddPayment, typeOfTransaction: TypeOfTransaction.Outcome,)));
  }

  void _openIncomeOverlay() {
    showModalBottomSheet(context: context, builder: ((context) => AdditionalPurchase(onAddExpense: widget.onAddPayment, typeOfTransaction: TypeOfTransaction.Income)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Available on card',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '\$${widget.availableOnCard}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Transfer limit', style: TextStyle(fontWeight: FontWeight.bold),),
                Text(
                  '\$${widget.limit}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: LinearProgressIndicator(
              minHeight: 2,
              color: Colors.black,
              value: widget.amountSpent / widget.limit,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Spent \$${widget.amountSpent.toString()}'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _openExpenseOverlay,
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(150, 50)),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Pay',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5,),
                      Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _openIncomeOverlay,
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(150, 50)),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: const Row(
                    children: [
                      Text('Deposit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Icon(Icons.add_circle, color: Colors.white,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
  }
}
