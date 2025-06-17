import 'package:agent360/screens/deposits_filtered_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetailFilterScreen extends StatefulWidget {
  const TransactionDetailFilterScreen({super.key});

  @override
  State<TransactionDetailFilterScreen> createState() =>
      _TransactionDetailFilterScreenState();
}

class _TransactionDetailFilterScreenState
    extends State<TransactionDetailFilterScreen> {
  String? selectedAmount;
  String? selectedPeriod;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedType;
  String? selectedSort;

  final Color selectedColor = const Color(0xFFB11226);
  final Color unselectedColor = Colors.black87;

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (startDate ?? initialDate)
          : (endDate ?? initialDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDate != null) {
      setState(() {
        if (isStart) {
          startDate = newDate;
        } else {
          endDate = newDate;
        }
      });
    }
  }

  Widget _buildFilterOption(
    String label,
    String? selectedValue,
    Function() onTap,
  ) {
    final isSelected = selectedValue == label;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.shade400,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : unselectedColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<String> options,
    String? selected,
    void Function(String) onSelect,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        Wrap(
          children: options
              .map(
                (option) => _buildFilterOption(
                  option,
                  selected,
                  () => onSelect(option),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          // Custom Red Header
          PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Container(
              color: const Color(0xFFB11226),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back + Title
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
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
                      const SizedBox(height: 16),
                      // Search + Filter + Add
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                hintText: 'Search',
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _iconButton(Icons.filter_list),
                          const SizedBox(width: 8),
                          _iconButton(Icons.add),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add Filters / Reset row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAmount = null;
                            selectedPeriod = null;
                            startDate = null;
                            endDate = null;
                            selectedType = null;
                            selectedSort = null;
                          });
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: selectedColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // trigger filter addition if needed
                        },
                        child: Text(
                          'Add filters',
                          style: TextStyle(
                            color: selectedColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  _buildSection(
                    'Amount',
                    ['<50 ₦', '100 - 500 ₦', '500 ₦ <'],
                    selectedAmount,
                    (val) => setState(() => selectedAmount = val),
                  ),

                  _buildSection(
                    'Period',
                    [
                      'Today',
                      'This week',
                      'This month',
                      'Previous month',
                      'This year',
                    ],
                    selectedPeriod,
                    (val) => setState(() => selectedPeriod = val),
                  ),

                  _sectionTitle('Select period'),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _pickDate(isStart: true),
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                          ),
                          label: Text(
                            startDate != null
                                ? DateFormat('dd MMM yyyy').format(startDate!)
                                : 'Start',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('–'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _pickDate(isStart: false),
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                          ),
                          label: Text(
                            endDate != null
                                ? DateFormat('dd MMM yyyy').format(endDate!)
                                : 'End',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),

                  _buildSection(
                    'Transactions',
                    ['Cash', 'Deposit'],
                    selectedType,
                    (val) => setState(() => selectedType = val),
                  ),

                  _buildSection(
                    'Sort by',
                    ['Newest to Oldest', 'Oldest to Newest'],
                    selectedSort,
                    (val) => setState(() => selectedSort = val),
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const DepositsFilteredResultScreen(),
                          ),
                        );
                      },

                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
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
