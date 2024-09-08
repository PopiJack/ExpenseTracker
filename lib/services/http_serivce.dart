import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/expense.dart';
import 'package:http/http.dart' as http;

class HttpService {
  String notionToken =
      "secret_7s89JEy30IzuSDG2FXJCPj2myvZmQPYAEJJ8tdIQJSt"; // Ensure this is securely managed
  final databaseID = "34c3695f06fe47e1ad2ec901972aed13";

  Future<List<Transaction>> fetchDatabaseElements() async {
    final url = 'https://api.notion.com/v1/databases/$databaseID/query';
    final headers = {
      'Authorization': 'Bearer $notionToken',
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json',
    };

    List<Transaction> transactionsList = [];

    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> results = jsonResponse['results'];

      for (int i = 0; i < results.length; i++) {
        Transaction transaction =
            Transaction.fromJson(results[i]['properties']);
        transactionsList.add(transaction);
      }
      return transactionsList;
    } else {
      debugPrint('Failed to load data. Status code: ${response.statusCode}');
      return []; // Return an empty list if the request fails
    }
  }

  Future<void> sendDataToNotion(Transaction transactionToSend) async {
    const url = 'https://api.notion.com/v1/pages';
    final headers = {
      'Authorization': 'Bearer $notionToken',
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> data = {
      'parent': {
        'type': 'database_id',
        'database_id': databaseID,
      },
      'properties': {
        'Name': {
          'title': [
            {
              'text': {
                'content': transactionToSend.title,
              },
            }
          ],
        },
        'Category': {
          'select': {
            'name': transactionToSend.category.toString().split('.').last,
          },
        },
        'Date of Expense': {
          'date': {
            'start': transactionToSend.date.toIso8601String(),
          },
        },
        'Amount': {
          'number': transactionToSend.amount,
        },
        'Method of Payment': {
          'select': {
            'name': transactionToSend.methodOfPayment.toString().split('.').last,
          },
        },
        'Type of transaction': {
          'select': {
            'name': transactionToSend.typeOfTransaction.toString().split('.').last,
          },
        },
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('Data successfully sent to Notion!');
      debugPrint(response.body);
    } else {
      debugPrint('Failed to send data. Status code: ${response.statusCode}');
      debugPrint(response.body);
    }
  }
}
