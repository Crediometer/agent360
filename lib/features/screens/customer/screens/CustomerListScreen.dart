import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'customer_detail_screen.dart';

class Customer {
  final String name;
  final String imageUrl;
  final String status; // e.g. Active, Inactive
  final String accountType; // e.g. Savings, Current

  Customer({
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.accountType,
  });
}

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedStatus = 'All';
  String selectedAccountType = 'All';

  final List<Customer> allCustomers = [
    Customer(name: "Aliyu Adebayo", imageUrl: "https://i.pravatar.cc/100?img=1", status: "Active", accountType: "Savings"),
    Customer(name: "Saratu Ali", imageUrl: "https://i.pravatar.cc/100?img=2", status: "Inactive", accountType: "Current"),
    Customer(name: "Joseph Brown", imageUrl: "https://i.pravatar.cc/100?img=3", status: "Active", accountType: "Savings"),
    Customer(name: "Abayomi Abubakar", imageUrl: "https://i.pravatar.cc/100?img=4", status: "Inactive", accountType: "Current"),
    Customer(name: "Samuel Williams", imageUrl: "https://i.pravatar.cc/100?img=5", status: "Active", accountType: "Current"),
    Customer(name: "Ijeoma Agwuegbo", imageUrl: "https://i.pravatar.cc/100?img=6", status: "Inactive", accountType: "Savings"),
    Customer(name: "Nnamdi Akintola", imageUrl: "https://i.pravatar.cc/100?img=7", status: "Active", accountType: "Savings"),
  ];

  List<Customer> get filteredCustomers {
    return allCustomers.where((customer) {
      final matchesSearch = customer.name.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesStatus = selectedStatus == 'All' || customer.status == selectedStatus;
 return matchesSearch && matchesStatus;

    }).toList();
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Filter Customers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
        
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedAccountType,
                decoration: const InputDecoration(labelText: 'Account Type'),
                items: ['All', 'Savings', 'Current']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (val) => setState(() => selectedAccountType = val!),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB62025)),
                child: const Text('Apply Filter'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFB62025),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Customer List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
          Container(
            color: const Color(0xFFB62025),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _openFilterSheet,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredCustomers.length,
                itemBuilder: (context, index) {
                  final customer = filteredCustomers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(customer.imageUrl),
                      ),
                      title: Text(customer.name),
                     subtitle: Text(customer.status),

                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerDetailScreen(customer: customer),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
