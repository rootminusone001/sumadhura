import 'package:flutter/material.dart';
import 'package:sumadhura/features/dashboard_screen/screen/dashboard_screen.dart';
import 'package:sumadhura/features/qr_code_scanner/screen/qr_code_scanner_screen.dart';
import 'package:sumadhura/features/visitor/screen/visitor_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardScreen(
            onViewVisitors: () => _onItemTapped(1),
            onScanQr: () => _onItemTapped(2),
          ),
          const VisitorsScreen(),
          QRCodeScannerScreen(isActive: _selectedIndex == 2),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Visitors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            activeIcon: Icon(Icons.qr_code),
            label: 'Scan QR',
          ),
        ],
      ),
    );
  }
}
