import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/features/screens/payments/screens/payment_method_screen.dart';
import 'package:agent360/features/screens/payments/screens/secure_payment_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';

class DepositFundsScreen extends StatefulWidget {
  const DepositFundsScreen({super.key});

  @override
  State<DepositFundsScreen> createState() => _DepositFundsScreenState();
}

class _DepositFundsScreenState extends State<DepositFundsScreen> {
  String? selectedCustomer;
  String? selectedQuickAmount;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<String> customers = ['Customer A', 'Customer B', 'Customer C'];
  final List<String> quickAmounts = ['₦500', '₦1 000', '₦1 500', '₦5 000'];

  void _updateIncome() {
    setState(() {});
  }

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
                      'Deposit Funds',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: NotificationIconWithBadge(
                      unreadCount: 1,
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            // White card
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
                    const SizedBox(height: 24),

                    // Editable amount field
                 Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _amountController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    ? '0.00'
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


                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'First Income',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₦0.00',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Customer dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text('Select customer name'),
                          value: selectedCustomer,
                          isExpanded: true,
                          onChanged: (val) =>
                              setState(() => selectedCustomer = val),
                          items: customers
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Note input
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText: 'Add note',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Quick Amount buttons
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: quickAmounts.map((amt) {
                        final isSelected = selectedQuickAmount == amt;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedQuickAmount = amt;
                              final numericValue = amt.replaceAll(
                                RegExp(r'[^\d.]'),
                                '',
                              );
                              _amountController.text = numericValue;
                            });
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFB11226)
                                  : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              amt,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFFB11226),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PaymentMethodScreen(),
                                ),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF007136,
                              ), // ✅ Green Submit
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9E9E9E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
