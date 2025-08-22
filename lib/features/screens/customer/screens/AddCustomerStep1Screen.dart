import 'dart:convert';
import 'package:agent360/features/screens/shared/screens/Tabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:agent360/features/utils/token_storage.dart';

class AddCustomerStep1Screen extends StatefulWidget {
  const AddCustomerStep1Screen({super.key});

  @override
  State<AddCustomerStep1Screen> createState() => _AddCustomerStep1ScreenState();
}

class _AddCustomerStep1ScreenState extends State<AddCustomerStep1Screen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _businessSize = "Small"; // default
  final TextEditingController _locationContactPhoneController =
      TextEditingController();
  final TextEditingController _locationContactEmailController =
      TextEditingController();

  bool isLoading = false;

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Future<void> _createCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final token = await getToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token not found. Please login again.")),
        );
        return;
      }

      final response = await http.post(
        Uri.parse("https://agent360.onrender.com/api/v1/customers"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "customerName": _customerNameController.text.trim(),
          "businessName": _businessNameController.text.trim(),
          "location": _locationController.text.trim(),
          "email": _emailController.text.trim(),
          "phoneNumber": _phoneNumberController.text.trim(),
          "businessSize": _businessSize, // ✅ Proper Enum
          "locationContactPhone": _locationContactPhoneController.text.trim(),
          "locationContactEmail": _locationContactEmailController.text.trim(),
          "primaryOwner": "6899c8113d9c058cf81dd7c8", // ✅ TEMP FIX
          "createdBy": "6899c8113d9c058cf81dd7c8", // ✅ TEMP FIX
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Customer created successfully")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const MainLayout(initialIndex: 2), // 👈 Customers tab
          ),
          (route) => false,
        );
      } else {
        debugPrint("Error: ${response.body}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed: ${response.body}")));
      }
    } catch (e) {
      debugPrint("Exception: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Customer"),
        backgroundColor: const Color(0xFFB62025),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: inputDecoration("Customer Name"),
                validator: (val) => val!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _businessNameController,
                decoration: inputDecoration("Business Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: inputDecoration("Location"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration("Email"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: inputDecoration("Phone Number"),
              ),
              const SizedBox(height: 16),

              // ✅ Dropdown for Business Size
              DropdownButtonFormField<String>(
                value: _businessSize,
                items: ["Small", "Medium", "Large", "Enterprise"]
                    .map(
                      (size) =>
                          DropdownMenuItem(value: size, child: Text(size)),
                    )
                    .toList(),
                decoration: inputDecoration("Business Size"),
                onChanged: (val) => setState(() => _businessSize = val!),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _locationContactPhoneController,
                decoration: inputDecoration("Location Contact Phone"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationContactEmailController,
                decoration: inputDecoration("Location Contact Email"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _createCustomer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB62025),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Create Customer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
