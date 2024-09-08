import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/main_screen.dart';
import 'package:flutter_application_2/models/list_of_expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<ListOfTransactions>(
        future: ListOfTransactions.create(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
          } else if (snapshot.hasData) {
            return MainScreen(listOfTransactions: snapshot.data!);
          } else {
            return Scaffold(body: Center(child: Text('No data available')));
          }
        },
      ),
    );
  }
}

