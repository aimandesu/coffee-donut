import 'package:flutter/material.dart';
import 'package:thor_coffee_donut/profile/profile.dart';

import 'cart/cart.dart';
import 'home/home.dart';

class MainLayoutController extends StatefulWidget {
  static const routeName = "/main-layout-controller";
  const MainLayoutController({super.key});

  @override
  State<MainLayoutController> createState() => _MainLayoutControllerState();
}

class _MainLayoutControllerState extends State<MainLayoutController> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const Home(),
        'title': 'Home',
      },
      {
        'page': const Cart(),
        'title': 'Cart',
      },
      {
        'page': const Profile(),
        'title': 'Profile',
      },
    ].toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActionWidget() {
      if (_pages[_selectedPageIndex]['title'].toString() == "Profil") {
        return [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ];
      } else {
        return [];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: appBarActionWidget(),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPageIndex,
          // elevation: 10,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          onTap: _selectPage,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.home,
                  size: 30,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.shopping_bag,
              ),
              label: 'Cart',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 30,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.face,
              ),
              label: 'Profile',
              activeIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.face,
                  size: 30,
                ),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: const Icon(Icons.data_array_rounded),
            //   label: 'Data',
            //   activeIcon: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     child: const Icon(
            //       Icons.data_array_rounded,
            //       size: 40,
            //     ),
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   icon: const Icon(Icons.people_rounded),
            //   label: 'Profil',
            //   activeIcon: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     child: const Icon(
            //       Icons.people_rounded,
            //       size: 40,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
