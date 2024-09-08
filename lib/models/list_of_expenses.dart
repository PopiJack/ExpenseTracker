import 'package:flutter_application_2/models/expense.dart';
import 'package:flutter_application_2/services/http_serivce.dart';

class ListOfTransactions {
  List<Transaction> _listOfTransactions = [];

  Future<void> _fetchTransactions() async {
    _listOfTransactions = await HttpService().fetchDatabaseElements();
  }

  static Future<ListOfTransactions> create() async {
    ListOfTransactions transactions = ListOfTransactions();
    await transactions._fetchTransactions();
    return transactions;
  }

  List<Transaction> get listOftransactions => _listOfTransactions;

  void addTransaction(Transaction additionalTransaction) async {
    _listOfTransactions.add(additionalTransaction);
    await HttpService().sendDataToNotion(additionalTransaction);
  }

  void removeTransaction(Transaction removableTransaction) {}

  double getAmountForCategory(Category choosedCategory, DateTime startDate) {
    double amount = 0;

    for (Transaction currentTransaction in _listOfTransactions
        .where((transaction) => transaction.date.isAfter(startDate))
        .toList()) {
      if (currentTransaction.category == choosedCategory &&
          currentTransaction.typeOfTransaction == TypeOfTransaction.Outcome) {
        amount += currentTransaction.amount;
      }
    }

    return amount;
  }

  double getTotalAmount(DateTime startDate) {
    double amount = 0;

    for (Transaction currentTransaction in _listOfTransactions
        .where((transaction) => transaction.date.isAfter(startDate))
        .toList()) {
      if (currentTransaction.typeOfTransaction == TypeOfTransaction.Outcome) {
        amount += currentTransaction.amount;
      }
    }

    return amount;
  }

  double getPercentForCategory(Category category, DateTime startDate) {
    if (getTotalAmount(startDate) == 0) {
      return 0;
    }
    ;
    return getAmountForCategory(category, startDate) /
        getTotalAmount(startDate) *
        100;
  }

  List<Transaction> getFilteredTransactions(DateTime startDate) {
    return _listOfTransactions
        .where((transaction) => transaction.date.isAfter(startDate))
        .toList();
  }
}
