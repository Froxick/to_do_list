import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/statics_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectScreen = 0;
  final List<Widget> _widgets = <Widget>[
    HomeScrean(),
    StaticsScreen(),
  ];

  void _setIndex(int index) {
    setState(() {
      _selectScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgets.elementAt(_selectScreen),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Дом'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Статистика')
        ],
        currentIndex: _selectScreen,
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        selectedItemColor: const Color.fromARGB(255, 112, 184, 53),
        onTap: _setIndex,
      ),
    );
  }
}
