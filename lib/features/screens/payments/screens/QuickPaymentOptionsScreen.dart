import 'package:agent360/features/screens/deposits/screens/Deposit-Rate-screen.dart';
import 'package:agent360/features/screens/shared/screens/advanceFundsScreen.dart';
import 'package:agent360/features/screens/deposits/screens/deposit_funds_screen.dart';
import 'package:agent360/features/screens/withdrawals/screens/withdraw_funds_screen.dart';
import 'package:flutter/material.dart';

class QuickPaymentOptionsScreen extends StatelessWidget {
  const QuickPaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        title: const Text("Payment", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quick payment options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("Select what you would like to do today"),
            const SizedBox(height: 24),
           Expanded(
  child: GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 1.1,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    children: [
      _buildOption(
        icon: Icons.savings,
        title: "Deposit",
        subtitle: "Fund your account",
        iconBg: const Color(0xFFCCF0F4),
        iconColor: const Color(0xFF017B8B),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DepositFundsScreen(),
            ),
          );
        },
      ),
      _buildOption(
        icon: Icons.credit_card,
        title: "Withdrawal",
        subtitle: "Take out of your balance",
        iconBg: const Color(0xFFFCDCDC),
        iconColor: const Color(0xFFB42D2D),
         onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const WithdrawFundsScreen(),
            ),
          );
        },
      ),
      _buildOption(
        icon: Icons.rocket_launch,
        title: "Advance",
        subtitle: "Get funds now,\npay later",
        iconBg: const Color(0xFFE1F3E6),
        iconColor: const Color(0xFF047C3F),
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdvanceFundsScreen(),
            ),
          );
        },
      ),
      _buildOption(
        icon: Icons.percent,
        title: "Deposit rate",
        subtitle: "Set deposit rate",
        iconBg: const Color(0xFFF9E8E8),
        iconColor: const Color(0xFFA70F1A),
         onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DepositRateScreen(),
            ),
          );
        },
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconBg,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: iconBg,
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
void _showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Coming soon...'),
      duration: Duration(seconds: 2),
    ),
  );
}
