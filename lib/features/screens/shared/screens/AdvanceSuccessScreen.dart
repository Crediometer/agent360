import 'package:flutter/material.dart';
import '../../dashboard/screens/DashboardScreen.dart';

class AdvanceSuccessScreen extends StatelessWidget {
  const AdvanceSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
      body: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0F2E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 48, color: Colors.white),
                    foregroundDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF017A36),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Great!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Advance of ', style: TextStyle(fontSize: 16)),
                          TextSpan(
                            text: '100.000',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF017A36),
                            ),
                          ),
                          TextSpan(text: '\nsuccessfully processed.', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Thank you for your transaction!',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const DashboardScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA70F1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
