import 'package:agent360/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';

class TransactionSuccessUIScreen extends StatelessWidget {
  final String title;
  final String message;
  final double amount;
  final VoidCallback? onDone;

  const TransactionSuccessUIScreen({
    super.key,
    required this.title,
    required this.message,
    required this.amount,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F), // Red top background
      body: Column(
        children: [
          const SizedBox(height: 100),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    const Text(
                      'Great!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        text: 'Payment of ',
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                            text: '${amount.toStringAsFixed(3)}\$',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF007136),
                            ),
                          ),
                          const TextSpan(
                            text: ' successfully processed.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                            (_) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Back to dashboard',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF007136),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 50, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
