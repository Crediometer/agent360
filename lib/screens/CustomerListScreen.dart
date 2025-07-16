import 'package:agent360/screens/notification_screen.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'customer_detail_screen.dart';

class Customer {
  final String name;
  final String imageUrl;

  Customer({required this.name, required this.imageUrl});
}

class CustomerListScreen extends StatelessWidget {
  final List<Customer> customers = [
    Customer(
      name: "Aliyu Adebayo",
      imageUrl: "https://i.pravatar.cc/100?img=1",
    ),
    Customer(name: "Saratu Ali", imageUrl: "https://i.pravatar.cc/100?img=2"),
    Customer(name: "Joseph Brown", imageUrl: "https://i.pravatar.cc/100?img=3"),
    Customer(
      name: "Abayomi Abubakar",
      imageUrl: "https://i.pravatar.cc/100?img=4",
    ),
    Customer(
      name: "Samuel Williams",
      imageUrl: "https://i.pravatar.cc/100?img=5",
    ),
    Customer(
      name: "Ijeoma Agwuegbo",
      imageUrl: "https://i.pravatar.cc/100?img=6",
    ),
    Customer(
      name: "Nnamdi Akintola",
      imageUrl: "https://i.pravatar.cc/100?img=7",
    ),
  ];

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
                    onPressed: () {
                      // Implement your filter logic here
                    },
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
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
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
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerDetailScreen(customer: customer),
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
