import 'dart:convert';
import 'package:agent360/features/screens/notification/screens/notification_screen.dart';
import 'package:agent360/features/utils/token_storage.dart';
import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agent360/services/network_service.dart';
import 'package:agent360/services/offline_storage_service.dart';
import 'customer_detail_screen.dart';

class Customer {
  final String id;
  final String customerName;
  final String businessName;
  final String location;
  final String email;
  final String phoneNumber;
  final String businessSize;
  final String? locationContactPhone;
  final String? locationContactEmail;
   final String? imageUrl;

  Customer({
    required this.id,
    required this.customerName,
    required this.businessName,
    required this.location,
    required this.email,
    required this.phoneNumber,
    required this.businessSize,
    this.locationContactPhone,
    this.locationContactEmail,
       this.imageUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'] ?? '',
      customerName: json['customerName'] ?? 'Unknown',
      businessName: json['businessName'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      businessSize: json['businessSize'] ?? '',
      locationContactPhone: json['locationContactPhone'],
      locationContactEmail: json['locationContactEmail'],
    );
  }
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
  List<Customer> allCustomers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final token = await getToken();
      if (token == null) {
        debugPrint("No token found. Please login first.");
        setState(() => isLoading = false);
        return;
      }

      // If token is an offline token or there is no internet, load cached customers
      final isOfflineToken = token.startsWith('offline_');
      final isConnected = await NetworkService().checkInternetConnection();

      if (isOfflineToken || !isConnected) {
        final cached = await OfflineStorageService.getCustomers();
        setState(() {
          allCustomers = cached.map((m) {
            return Customer(
              id: (m['_id'] ?? m['id'] ?? '').toString(),
              customerName: (m['customerName'] ?? 'Unknown').toString(),
              businessName: (m['businessName'] ?? '').toString(),
              location: (m['location'] ?? '').toString(),
              email: (m['email'] ?? '').toString(),
              phoneNumber: (m['phoneNumber'] ?? '').toString(),
              businessSize: (m['businessSize'] ?? '').toString(),
              locationContactPhone: m['locationContactPhone']?.toString(),
              locationContactEmail: m['locationContactEmail']?.toString(),
            );
          }).toList();
          isLoading = false;
        });
        return;
      }

      // Online fetch
      final response = await http.get(
        Uri.parse("https://agent360.onrender.com/api/v1/customers"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> customersJson = data['data']['customers'] ?? [];

        // Cache for offline usage
        final List<Map<String, dynamic>> cacheable = customersJson
            .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        await OfflineStorageService.saveCustomers(cacheable);

        setState(() {
          allCustomers = customersJson
              .map((json) => Customer.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        // On server error, try offline cache as fallback
        final cached = await OfflineStorageService.getCustomers();
        if (cached.isNotEmpty) {
          setState(() {
            allCustomers = cached.map((m) {
              return Customer(
                id: (m['_id'] ?? m['id'] ?? '').toString(),
                customerName: (m['customerName'] ?? 'Unknown').toString(),
                businessName: (m['businessName'] ?? '').toString(),
                location: (m['location'] ?? '').toString(),
                email: (m['email'] ?? '').toString(),
                phoneNumber: (m['phoneNumber'] ?? '').toString(),
                businessSize: (m['businessSize'] ?? '').toString(),
                locationContactPhone: m['locationContactPhone']?.toString(),
                locationContactEmail: m['locationContactEmail']?.toString(),
              );
            }).toList();
            isLoading = false;
          });
        } else {
          throw Exception("Failed to load customers: ${response.body}");
        }
      }
    } catch (e) {
      // Network failure: fallback to offline cache
      try {
        final cached = await OfflineStorageService.getCustomers();
        setState(() {
          allCustomers = cached.map((m) {
            return Customer(
              id: (m['_id'] ?? m['id'] ?? '').toString(),
              customerName: (m['customerName'] ?? 'Unknown').toString(),
              businessName: (m['businessName'] ?? '').toString(),
              location: (m['location'] ?? '').toString(),
              email: (m['email'] ?? '').toString(),
              phoneNumber: (m['phoneNumber'] ?? '').toString(),
              businessSize: (m['businessSize'] ?? '').toString(),
              locationContactPhone: m['locationContactPhone']?.toString(),
              locationContactEmail: m['locationContactEmail']?.toString(),
            );
          }).toList();
          isLoading = false;
        });
      } catch (_) {
        setState(() => isLoading = false);
      }
      debugPrint("Error fetching customers: $e");
    }
  }

  List<Customer> get filteredCustomers {
    return allCustomers.where((customer) {
      final matchesSearch = customer.customerName.toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );

      return matchesSearch; // abhi sirf search filter
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
              const Text(
                'Filter Customers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['All', 'Active', 'Inactive']
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => selectedStatus = val!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedAccountType,
                decoration: const InputDecoration(labelText: 'Account Type'),
                items: ['All', 'Savings', 'Current']
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => selectedAccountType = val!),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB62025),
                ),
                child: const Text('Apply Filter'),
              ),
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredCustomers.isEmpty
                  ? const Center(child: Text("No customers found"))
                  : ListView.builder(
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
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://i.pravatar.cc/100?img=65", // dummy image
                              ),
                            ),
                            title: Text(customer.customerName),
                            subtitle: Text(customer.businessName),
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
