import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  bool get _isFormValid =>
      _emailController.text.isNotEmpty &&
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _passwordController.text.length >= 8 &&
      _passwordController.text == _confirmController.text;

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 14);
  }

  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return {
        'deviceId': androidInfo.id ?? 'unknown',
        'deviceType': 'MOBILE',
        'platform': 'Android',
        'model': androidInfo.model ?? 'unknown',
        'osVersion': androidInfo.version.release ?? 'unknown',
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        'deviceId': iosInfo.identifierForVendor ?? 'unknown',
        'deviceType': 'MOBILE',
        'platform': 'iOS',
        'model': iosInfo.utsname.machine ?? 'unknown',
        'osVersion': iosInfo.systemVersion ?? 'unknown',
      };
    } else {
      return {
        'deviceId': 'unknown',
        'deviceType': 'UNKNOWN',
        'platform': 'flutter',
        'model': 'unknown',
        'osVersion': 'unknown',
      };
    }
  }

  Future<void> _onRegister() async {
    if (!_isFormValid) {
      _showToast('Please fill all fields correctly.');
      return;
    }

    setState(() => _isLoading = true);

    final deviceInfo = await getDeviceInfo();

    final body = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'deviceInfo': {
        'deviceId': deviceInfo['deviceId'],
        'deviceType': deviceInfo['deviceType'],
        'platform': deviceInfo['platform'],
        'model': deviceInfo['model'],
        'osVersion': deviceInfo['osVersion'],
      },
    };

    try {
      final response = await http
          .post(
            Uri.parse('https://agent360.onrender.com/api/v1/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw TimeoutException('Request timed out');
            },
          );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _showToast('Account created successfully! Please verify your email.');
        Navigator.pop(context);
      } else if (response.statusCode == 400 && data['errors'] != null) {
        final errors = data['errors'] as Map<String, dynamic>;
        String firstError = errors.entries.first.value[0];
        _showToast(firstError);
      } else {
        _showToast(data['message'] ?? 'Registration failed. Try again.');
      }
    } on TimeoutException {
      _showToast('Request Timed Out. Try Again.');
    } on http.ClientException catch (e) {
      _showToast('Network Error: ${e.message}');
    } catch (e) {
      _showToast('Unexpected Error: $e');
    }

    setState(() => _isLoading = false);
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 91,
          height: 79,
          decoration: BoxDecoration(
            color: const Color(0xFFA61111),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Positioned(
                  left: 10,
                  child: Text(
                    'a',
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 25,
                  child: Text(
                    '360',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'agent360',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formField(String label, TextEditingController c,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          obscureText: isPassword && !_passwordVisible,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(child: _buildLogo()),
                const SizedBox(height: 32),
                const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
                _formField('Email', _emailController),
                const SizedBox(height: 16),
                _formField('First Name', _firstNameController),
                const SizedBox(height: 16),
                _formField('Last Name', _lastNameController),
                const SizedBox(height: 16),
                _formField('Password', _passwordController, isPassword: true),
                const SizedBox(height: 16),
                _formField('Confirm Password', _confirmController, isPassword: true),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isFormValid && !_isLoading ? _onRegister : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? const Color(0xFFA61111)
                          : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : Text(
                            'Register',
                            style: TextStyle(
                              color: _isFormValid ? Colors.white : Colors.black,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Already have an account? Sign in',
                    style: TextStyle(fontSize: 12, color: Color(0xFF0A5728)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
