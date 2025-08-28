import 'dart:convert';
import 'package:agent360/features/screens/Auth/screens/ForgotPasswordScreen.dart';
import 'package:agent360/features/utils/token_storage.dart';
import 'package:agent360/services/offline_storage_service.dart';
import 'package:agent360/services/network_service.dart';
// import 'package:agent360/features/screens/Auth/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _agentIdController = TextEditingController();
  final _otpController = TextEditingController();

  bool _passwordVisible = false;
  bool _offlineMode = false;
  bool _isLoading = false;
  bool _otpRequired = false;

  bool get _isFormValid =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _agentIdController.text.isNotEmpty &&
      (!_otpRequired || _otpController.text.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
    _agentIdController.addListener(_onFormChanged);
    _otpController.addListener(_onFormChanged);
  }

  void _onFormChanged() => setState(() {});

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

Future<void> _login() async {
  setState(() => _isLoading = true);
  
  try {
    // Check if offline mode is enabled
    if (_offlineMode) {
      await _loginOffline();
      return;
    }

    // Check network connectivity
    final networkService = NetworkService();
    final isConnected = await networkService.checkInternetConnection();
    
    if (!isConnected) {
      // Try offline login if no internet
      await _loginOffline();
      return;
    }

    // Online login
    final uri = Uri.parse('https://agent360.onrender.com/api/v1/agent-auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": _emailController.text.trim(),
        "agentCode": _agentIdController.text.trim(),
        "password": _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['data']?['token'];
      final userData = jsonResponse['data']?['user'];

      if (token != null) {
        await saveToken(token);
        
        // Save user data for offline access
        if (userData != null) {
          await OfflineStorageService.saveUserData({
            ...userData,
            'email': _emailController.text.trim(),
            'agentCode': _agentIdController.text.trim(),
            'lastLogin': DateTime.now().toIso8601String(),
          });
        }

        _showToast("Login successful");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showToast("Token not found in response");
      }
    } else {
      _showToast("Error ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    // If online login fails, try offline login
    await _loginOffline();
  } finally {
    setState(() => _isLoading = false);
  }
}

Future<void> _loginOffline() async {
  try {
    final canLogin = await OfflineStorageService.canLoginOffline(
      _emailController.text.trim(),
      _agentIdController.text.trim(),
    );

    if (canLogin) {
      final userData = await OfflineStorageService.getUserData();
      if (userData != null) {
        // Create a temporary token for offline use
        final offlineToken = 'offline_${DateTime.now().millisecondsSinceEpoch}';
        await saveToken(offlineToken);
        
        _showToast("Logged in offline mode");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showToast("No cached user data found");
      }
    } else {
      _showToast("Cannot login offline. No cached credentials found.");
    }
  } catch (e) {
    _showToast("Offline login failed: $e");
  }
}
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _agentIdController.dispose();
    _otpController.dispose();
    super.dispose();
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

  Widget _formField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool isObscure = false,
    VoidCallback? togglePassword,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isObscure,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
            ),
            isDense: true,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: togglePassword,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('Offline', style: TextStyle(fontSize: 10)),
            Text('mode', style: TextStyle(fontSize: 10)),
          ],
        ),
        const SizedBox(width: 8),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: _offlineMode,
            onChanged: (val) {
              setState(() {
                _offlineMode = val;
              });
            },
            activeColor: const Color(0xFFA61111),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Center(child: _buildLogo()),
              const SizedBox(height: 32),
              const SizedBox(height: 8),
        
              const SizedBox(height: 24),
              _formField(
                label: 'Email',
                controller: _emailController,
                hint: 'you@example.com',
              ),

              const SizedBox(height: 16),
              _formField(
                label: 'Password',
                controller: _passwordController,
                isPassword: true,
                isObscure: !_passwordVisible,
                togglePassword: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                hint: '********',
              ),
              const SizedBox(height: 16),
              _formField(
                label: 'Agent ID',
                controller: _agentIdController,
                hint: 'cred-12',
              ),
              if (_otpRequired) ...[
                const SizedBox(height: 16),
                _formField(
                  label: 'OTP Code',
                  controller: _otpController,
                  hint: 'Enter OTP sent to email/device',
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _isFormValid && !_isLoading ? _login : null,
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
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          'Sign in',
                          style: TextStyle(
                            color: _isFormValid ? Colors.white : Colors.black,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 12, color: Color(0xFF0A5728)),
                  ),
                ),
              ),
              const Spacer(),
              _buildOfflineToggle(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
