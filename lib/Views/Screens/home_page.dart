import 'package:budget_tracker_app_af_6/Views/Screens/Components/add_data_screen.dart';
import 'package:budget_tracker_app_af_6/Views/Screens/Components/view_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Components/add_spending_components.dart';
import 'Components/view_spending_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  List<Widget> pageList = [
    const Add_Data_Screen(),
    Add_Spending_Components(),
    const View_Data_Screen(),
    View_Spending_Screen()
  ];
  PageController pageController = PageController();
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (val) {
          setState(() {
            selectedIndex = val;
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(microseconds: 200),
              curve: Curves.linear,
            );
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.money), label: "Add Category"),
          NavigationDestination(icon: Icon(Icons.money), label: "Add Spending"),
          NavigationDestination(
              icon: Icon(Icons.category), label: "View Category"),
          NavigationDestination(
              icon: Icon(Icons.category), label: "View Spending"),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            selectedIndex = val;
            pageController.animateToPage(
              selectedIndex,
              duration: const Duration(microseconds: 200),
              curve: Curves.linear,
            );
          });
        },
        children: pageList,
      ),
    );
  }
}
