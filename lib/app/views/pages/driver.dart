import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/food_by_ingr_page.dart';
import 'package:food_track_app/app/views/pages/food_by_name_page.dart';

class PageDriver extends StatefulWidget {
  const PageDriver({super.key});

  @override
  State<PageDriver> createState() => _PageDriverState();
}

class _PageDriverState extends State<PageDriver> {
  List<Widget> pages = const [
    FoodByNamePage(title: "Food By Name"),
    FoodByIngridPage(title: "Food By Ingredients")
  ];

  late PageController _controller;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        children: pages,
        onPageChanged: (p) {
          setState(() => _currentPage = p);
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: (p) {
          _controller.animateToPage(p,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 100));
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dinner_dining), label: "Search By Name"),
          NavigationDestination(
              icon: Icon(Icons.dining_sharp), label: "Search By Ingredients")
        ],
      ),
    );
  }
}
