import 'package:agent360/features/screens/Auth/screens/verification_screen.dart';
import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';
import '../../deposits/screens/deposit_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showTransactionScreen = false;
  String selectedTransactionType = 'Deposit';

  void _navigateToTransactionScreen(String type) {
    setState(() {
      showTransactionScreen = true;
      selectedTransactionType = type;
    });
  }

  void _goBackToDashboard() {
    setState(() {
      showTransactionScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showTransactionScreen
        ? DepositTransactionScreen(
            onBack: _goBackToDashboard,
            type: selectedTransactionType,
          )
        : _buildDashboard(context);
  }

  Widget _buildDashboard(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildVerificationCard(),
              const SizedBox(height: 16),
              _buildTotalBalanceCard(),
              const SizedBox(height: 16),
              ..._buildInfoTiles(context),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Click a category to view details',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Roberta!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Agent-ID: cred-12', style: TextStyle(color: Colors.grey)),
          ],
        ),
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: NotificationIconWithBadge(
            unreadCount: 1,
            iconSize: 22,
            iconColor: Colors.black87,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Let's get you verified",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCC162D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: const RoundedRectangleBorder(), // No rounded corners
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VerificationScreen()),
              );
            },

            child: const Text("Verify", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFCC162D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Balance:',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                '₦ 0.00',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInfoTiles(BuildContext context) {
  final List<Map<String, dynamic>> data = [
    {
      'icon': Icons.account_balance,
      'label': 'Total Deposit:',
      'value': '₦ 0.00',
      'onTap': () => _navigateToTransactionScreen('Deposit'),
    },
    {
      'icon': Icons.account_balance_wallet,
      'label': 'Total Withdrawals:',
      'value': '₦ 0.00',
      'onTap': () => _navigateToTransactionScreen('Withdraw'),
    },
    {
      'icon': Icons.receipt_long,
      'label': 'Total Advances:',
      'value': '₦ 0.00',
      'onTap': () => _navigateToTransactionScreen('Advance'),
    },
    {
      'icon': Icons.sync_alt,
      'label': 'Available Balance:',
      'value': '₦ 0.00',
    },
    {
      'icon': Icons.monetization_on,
      'label': 'First Income:',
      'value': '₦ 0.00',
      'onTap': () => _navigateToTransactionScreen('First Income'),
    },
    {
      'icon': Icons.send,
      'label': 'Total Disbursement:',
      'value': '₦ 0.00',
    },
  ];

  return data
      .map(
        (item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: GestureDetector(
            onTap: item['onTap'] as VoidCallback?,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(item['icon'] as IconData, color: Colors.black54),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['label'] as String,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(
                    item['value'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      .toList();
}

}
