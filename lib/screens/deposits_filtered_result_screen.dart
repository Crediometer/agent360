import 'package:agent360/screens/TransactionDetailsScreen.dart';
import 'package:flutter/material.dart';

class DepositsFilteredResultScreen extends StatelessWidget {
  const DepositsFilteredResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFB11226);
    final List<Map<String, dynamic>> transactions = [
      {
        'name': 'Saratu Ali',
        'type': 'Deposit',
        'amount': '+489',
        'date': '16.11.2023',
      },
      {
        'name': 'Ijeoma Agwuegbo',
        'type': 'Deposit',
        'amount': '+200',
        'date': '17.11.2023',
      },
      {
        'name': 'Joseph Brown',
        'type': 'Deposit',
        'amount': '+240',
        'date': '19.11.2023',
      },
      {
        'name': 'Ijeoma Agwuegbo',
        'type': 'Deposit',
        'amount': '+360',
        'date': '22.11.2023',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          // Header
          Container(
            color: redColor,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Deposit  Transaction History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.grey, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _roundedIcon(Icons.filter_list),
                    const SizedBox(width: 8),
                    _roundedIcon(Icons.add),
                  ],
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TransactionDetailsScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.account_balance,
                              color: Colors.blue, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tx['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(tx['type'],
                                    style:
                                        const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(tx['amount'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(tx['date'],
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Section
          Container(
            color: redColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Back to Dashboard button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: const Text(
                      'Back to Dashboard',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tabs
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: const [
                //     Icon(Icons.home_rounded, color: redColor),
                //     Icon(Icons.wallet, color: Colors.white),
                //     Icon(Icons.people_alt, color: Colors.white),
                //     Icon(Icons.person_add, color: Colors.white),
                //     Icon(Icons.badge, color: Colors.white),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundedIcon(IconData icon) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}
