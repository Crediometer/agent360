import 'package:agent360/features/screens/shared/screens/AdvanceSuccessScreen.dart';
import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';

class AdvanceFundsScreen extends StatefulWidget {
  const AdvanceFundsScreen({super.key});
  @override
  State<AdvanceFundsScreen> createState() => _AdvanceFundsScreenState();
}

class _AdvanceFundsScreenState extends State<AdvanceFundsScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '0',
  );
  final TextEditingController _agentController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String selectedQuick = '';
  double interestRate = 3.5; // example
  double firstIncome = 0;

  void _updateIncome() {
    final amt = double.tryParse(_amountController.text) ?? 0;
    setState(() => firstIncome = (amt * interestRate / 100).roundToDouble());
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
      body: SafeArea(
        child: Column(
          children: [
            // → Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const BackButton(color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'Advance Funds',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
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

            // → White Card
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // a) Amount field
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFA5A5A5),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (_) => _updateIncome(),
                        ),
                        IgnorePointer(
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  const TextSpan(
                                    text: '₦ ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: _amountController.text.isEmpty
                                        ? ' 0.00'
                                        : _amountController.text,
                                    style: const TextStyle(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    // b) Interest & Income labels
                    Text(
                      'Interest Rate    ${interestRate.toStringAsFixed(1)}%',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'First Income      ₦${firstIncome.toStringAsFixed(3)}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    // c) Agent ID + Notes input
                    TextField(
                      controller: _agentController,
                      decoration: InputDecoration(
                        hintText: 'Agent ID',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Add notes',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // d) Quick amount buttons
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['₦50', '₦100', '₦500', '₦1000'].map((val) {
                        final sel = selectedQuick == val;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedQuick = val;
                              _amountController.text = val.replaceAll(
                                RegExp(r'[^\d.]'),
                                '',
                              );

                              _updateIncome();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: sel
                                  ? const Color(0xFF007136)
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              val,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: sel
                                    ? Colors.white
                                    : const Color(0xFF007136),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    // e) Submit / Cancel buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AdvanceSuccessScreen(),
                                ),
                              );
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
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9E9E9E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
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
}
