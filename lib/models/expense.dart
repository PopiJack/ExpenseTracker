import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category {
  Leisure,
  Food,
  Travel,
  Work,
}

const categoryIcons = {
  Category.Leisure: Icons.movie,
  Category.Food: Icons.lunch_dining,
  Category.Work: Icons.work,
  Category.Travel: Icons.travel_explore,
};

enum WaysOfPayment { Cash, Card, PayPal, ApplePay }

const categoryPaymentsIcons = {
  WaysOfPayment.Cash: Icons.money,
  WaysOfPayment.Card: Icons.credit_card,
  WaysOfPayment.PayPal: Icons.paypal,
  WaysOfPayment.ApplePay: Icons.apple,
};

enum TypeOfTransaction {
  Income,
  Outcome,
}

const typeOfTransactionIcons = {
  TypeOfTransaction.Income: Icons.south_west,
  TypeOfTransaction.Outcome: Icons.north_east,
};

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final WaysOfPayment methodOfPayment;
  final TypeOfTransaction typeOfTransaction;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.methodOfPayment,
    required this.typeOfTransaction,
  }) : id = uuid.v4();

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      title: json['Name']['title'][0]['text']['content'],
      amount: _parseAmount(json['Amount']['number']),
      date: DateTime.parse(json['Date of Expense']['date']['start']),
      category: Category.values.byName(json['Category']['select']['name']), // Modify based on your data
      methodOfPayment: WaysOfPayment.values.byName(json['Method of Payment']['select']['name']), // Modify based on your data
      typeOfTransaction: json['Type of transaction']['select']['name'] == 'Income' ? TypeOfTransaction.Income : TypeOfTransaction.Outcome, // Modify based on your data
    );
  }

  static double _parseAmount(var number) {
    if (number is int) {
      return number.toDouble();
    } else if (number == 0) {
      return 0;
    } else {
      return number;
    }
  }

  String get formattedDate => formatter.format(date);
}

final FilteredDates = {
  "Week": DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
  "Month": DateTime(DateTime.now().year, DateTime.now().month, 1),
  "Year": DateTime(DateTime.now().year, 1, 1),
 };