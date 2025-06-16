import 'package:flutter/material.dart';
import 'deposit_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showDepositScreen = false;

  void _navigateToDepositScreen() {
    setState(() {
      showDepositScreen = true;
    });
  }

  void _goBackToDashboard() {
    setState(() {
      showDepositScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showDepositScreen
        ? DepositTransactionScreen(onBack: _goBackToDashboard)
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Transaction overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.notifications_none, size: 26),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Hi Roberta!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'Agent-ID: cred-12',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 61, 61),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '0.00',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ..._buildInfoTiles(context),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Click a category to view details',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfoTiles(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'icon': Icons.account_balance,
        'label': 'Total Deposit:',
        'value': '₦ 0.00',
        'onTap': _navigateToDepositScreen,
      },
         {'icon': Icons.account_balance_wallet, 'label': 'Total Withdrawals:', 'value': '₦ 0.00'},
      {'icon': Icons.receipt_long, 'label': 'Total Advences:', 'value': '₦ 0.00'},
      {'icon': Icons.sync_alt, 'label': 'Available Balance:', 'value': '₦ 0.00'},
      {'icon': Icons.monetization_on, 'label': 'First Income:', 'value': '₦ 0.00'},
      {'icon': Icons.send, 'label': 'Total Amount Given Out:', 'value': '₦ 0.00'},

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
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
