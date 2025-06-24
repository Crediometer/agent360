import 'package:flutter/material.dart';
import 'dart:async';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  final TextEditingController _accountNumberController = TextEditingController(text: '1234567890');
  final TextEditingController _bankNameController = TextEditingController(text: 'Zenith Bank');
  final TextEditingController _accountNameController = TextEditingController(text: 'John Doe Enterprises');

  Timer? _timer;
  int _remainingSeconds = 20 * 60; // 20 minutes

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedRemaining {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
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
                      'Bank Transfer',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 4),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none, size: 20),
                  ),
                ],
              ),
            ),

            // Main Body
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildField('Account number', _accountNumberController),
                    const SizedBox(height: 16),
                    _buildField('Bank name', _bankNameController),
                    const SizedBox(height: 16),
                    _buildField('Account name', _accountNameController),
                    const SizedBox(height: 16),
                    const Text(
                      'Note: This transfer window will expire in 20 minutes. Please ensure you complete the transfer before the timer runs out.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),

                    // Timer
                    Row(
                      children: [
                        const Text('I have', style: TextStyle(fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Column(
                          children: [
                            AnimatedCircularTimer(seconds: _remainingSeconds),
                            const SizedBox(height: 8),
                            Text(_formattedRemaining, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    ElevatedButton(
                      onPressed: () {
                        // handle confirmation
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        'I have transferred',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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

  Widget _buildField(String label, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}

// A simple circular progress indicator based on remaining seconds.
class AnimatedCircularTimer extends StatelessWidget {
  final int seconds;
  const AnimatedCircularTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final total = 20 * 60;
    final progress = seconds / total;

    return SizedBox(
      width: 36,
      height: 36,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 4,
        backgroundColor: Colors.grey.shade300,
        color: const Color(0xFFD32F2F),
      ),
    );
  }
}
