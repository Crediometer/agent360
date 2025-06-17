import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFB11226);
    const titleStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      backgroundColor: redColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Main card
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    // Avatar and Name
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/user.jpg'), // or NetworkImage
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ijeoma Agwuegbo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                    const SizedBox(height: 12),
                    const Icon(Icons.account_balance, color: redColor, size: 30),
                    const SizedBox(height: 4),
                    const Text(
                      'Total Amount',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const Text(
                      '+263.382',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: redColor),
                    ),
                    const SizedBox(height: 24),

                    // Details
                    _detailRow(Icons.receipt_outlined, 'Transaction ID', '#353367473'),
                    _detailRow(Icons.account_balance_wallet_outlined, 'Deposit to',
                        'Savings ***6543'),
                    _detailRow(Icons.payment, 'Payment method', 'Cash'),
                    _detailRow(Icons.calendar_today, 'Date', '13.02.2025.'),
                    _detailRow(Icons.access_time, 'Time', '13:44'),
                    _detailRow(Icons.badge_outlined, 'Agent ID', 'cred-12'),
                    _detailRow(Icons.attach_money_outlined, 'Fee', '0 \$'),
                    _detailRow(Icons.note_outlined, 'Note', 'NA'),

                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _actionButton(Icons.download, 'Download'),
                        _actionButton(Icons.share, 'Share'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Tabs
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 12),
            //   color: redColor,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: const [
            //       Icon(Icons.home_rounded, color: redColor),
            //       Icon(Icons.wallet, color: Colors.white),
            //       Icon(Icons.people_alt, color: Colors.white),
            //       Icon(Icons.person_add, color: Colors.white),
            //       Icon(Icons.badge, color: Colors.white),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.red.shade800, size: 20),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: const Color(0xFFB11226)),
      label: Text(label, style: const TextStyle(color: Color(0xFFB11226))),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFB11226)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
