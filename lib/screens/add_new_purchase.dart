import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/drop_down_button_category.dart';
import 'package:flutter_application_2/components/drop_down_button_method.dart';
import 'package:flutter_application_2/models/expense.dart';

class AdditionalPurchase extends StatefulWidget {
  const AdditionalPurchase(
      {super.key, required this.onAddExpense, required this.typeOfTransaction});

  final void Function(Transaction expense) onAddExpense;
  final TypeOfTransaction typeOfTransaction;

  @override
  State<AdditionalPurchase> createState() => _AdditionalPurchaseState();
}

class _AdditionalPurchaseState extends State<AdditionalPurchase> {
  final _titleEdittingController = TextEditingController();
  final _sumEdittingController = TextEditingController();
  DateTime? _selectedDate;
  Category _currentCategoryValue = Category.values[0];
  WaysOfPayment _currentPurchaseMethodValue = WaysOfPayment.values[0];

  void _addToSum() {
    widget.onAddExpense(Transaction(
      title: _titleEdittingController.text,
      amount: double.tryParse(_sumEdittingController.text) ?? 0.00,
      date: _selectedDate!,
      category: _currentCategoryValue,
      methodOfPayment: _currentPurchaseMethodValue,
      typeOfTransaction: widget.typeOfTransaction,
    ));
    Navigator.pop(context);
  }

  void setCategoryValue(Category newValue) {
    setState(() {
      _currentCategoryValue = newValue;
    });
  }

  void setPurchaseMethodValue(WaysOfPayment newValue) {
    setState(() {
      _currentPurchaseMethodValue = newValue;
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final date = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: DateTime.now());

    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomDropDownButton2(
                dropDownValues: WaysOfPayment.values,
                onChanged: setPurchaseMethodValue,
              ),
              CustomDropDownButton(
                dropDownValues: Category.values,
                onChanged: setCategoryValue,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
            ),
            controller: _titleEdittingController,
            decoration: InputDecoration(
              hintText: widget.typeOfTransaction == TypeOfTransaction.Income
                  ? 'Name of an Income'
                  : 'Name of an Expense',
              border: InputBorder.none,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
            ),
            controller: _sumEdittingController,
            decoration: const InputDecoration(
              hintText: '00.00',
              border: InputBorder.none,
            ),
          ),
          ElevatedButton(
              onPressed: _presentDatePicker,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!), style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.calendar_month, color: Colors.black,),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: _addToSum, child: const Text('save', style: TextStyle(color: Colors.black),))
        ],
      ),
    );
  }
}
