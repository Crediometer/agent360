import 'package:agent360/features/screens/reader/screens/CredioReaderScreen.dart';
import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';
import '../../transactions/screens/bank_transfer_screen.dart';
// import 'credio_reader_screen.dart';

class WithdrawalPaymentMethodScreen extends StatefulWidget {
  const WithdrawalPaymentMethodScreen({super.key});

  @override
  State<WithdrawalPaymentMethodScreen> createState() =>
      _WithdrawalPaymentMethodScreenState();
}

class _WithdrawalPaymentMethodScreenState
    extends State<WithdrawalPaymentMethodScreen> {
  String selectedMethod = 'Cash';

  final List<String> methods = ['Cash', 'Transfer', 'Credio Reader'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
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
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  NotificationIconWithBadge(
                    unreadCount: 1,
                    iconSize: 24,
                    iconColor: Colors.black,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Card content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    ...methods
                        .map((method) => _buildRadioTile(method))
                        .toList(),

                    const Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              switch (selectedMethod) {
                                case 'Transfer':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const BankTransferScreen(),
                                    ),
                                  );
                                  break;
                                case 'Credio Reader':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const CredioReaderScreen(),
                                    ),
                                  );
                                  break;
                                case 'Cash':
                                default:
                                  Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007136),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9E9E9E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          Radio<String>(
            value: label,
            groupValue: selectedMethod,
            activeColor: Colors.black,
            onChanged: (val) {
              setState(() {
                selectedMethod = val!;
              });
            },
          ),
        ],
      ),
    );
  }
}
