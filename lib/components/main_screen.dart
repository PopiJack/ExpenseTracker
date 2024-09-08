import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/custom_bottom_navigation_bar.dart';
import 'package:flutter_application_2/models/list_of_expenses.dart';
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:flutter_application_2/screens/insight_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.listOfTransactions});

  final ListOfTransactions listOfTransactions;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  @override
  void initState() {
    _pages = [
      MyHomePage(
        transactionList: widget.listOfTransactions,
      ),
      InsigthPage(
        transactionList: widget.listOfTransactions,
      ),
    ];
    super.initState();
  }

  void _navigateToNewPage(int index) {
    if (_currentIndex == index) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _navigateToNewPage,
      ),
    );
  }
}
