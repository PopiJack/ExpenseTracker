import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.onTap});

  final void Function(int value) onTap;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.black,
        useLegacyColorScheme: false,
        unselectedLabelStyle:
            const TextStyle(color:  Color.fromARGB(255, 186, 186, 186)),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        onTap: (value) {
          widget.onTap(value);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.house_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.house,
                color: Colors.white,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.data_usage_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(Icons.data_usage),
              label: 'Insight'),
        ]); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}
