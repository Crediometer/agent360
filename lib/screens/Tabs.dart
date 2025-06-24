import 'package:agent360/screens/deposit_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'DashboardScreen.dart';

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
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

 final List<Widget> _screens = const [
  DashboardScreen(),
  Placeholder(), // Customers
  Placeholder(), // Agents
  Placeholder(), // Profile
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
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
          color: Color(0xFFCC162D), // 🔴 your custom red
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
      color: Color(0xFFCC162D),
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.wallet, color: Colors.white),
  ),
  label: 'Transactions',
),
 
    const BottomNavigationBarItem(
      icon: Icon(Icons.people_alt),
      label: 'Customers',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_add),
      label: 'Agents',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.badge),
      label: 'Profile',
    ),
  ],
),

    );
  }
}
