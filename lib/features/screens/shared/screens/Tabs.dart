import 'package:agent360/features/screens/customer/screens/AddCustomerStep1Screen.dart';
import 'package:agent360/features/screens/customer/screens/CustomerListScreen.dart';
import 'package:agent360/features/screens/payments/screens/QuickPaymentOptionsScreen.dart';
import 'package:agent360/features/screens/profile/screens/profileScreen.dart';
import 'package:agent360/widgets/offline_status_widget.dart';
import 'package:flutter/material.dart';

import '../../dashboard/screens/DashboardScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  final int initialIndex;
  const MainLayout({super.key, this.initialIndex = 0}); // 👈 default 0

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 👈 yahan se set hoga
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const QuickPaymentOptionsScreen(),
    CustomerListScreen(),
    const AddCustomerStep1Screen(),
    AgentProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const OfflineStatusWidget(),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFCC162D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home_rounded, color: Colors.white),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.wallet),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                // 👈 yeh correct hai
                color: Color(0xFFCC162D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wallet, color: Colors.white),
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_alt),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFCC162D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.people_alt, color: Colors.white),
            ),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_add),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFCC162D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_add, color: Colors.white),
            ),
            label: 'Agents',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.badge),
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFCC162D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.badge, color: Colors.white),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
