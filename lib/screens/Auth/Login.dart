import 'package:agent360/screens/Auth/ForgotPasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _agentIdController = TextEditingController();

  bool _passwordVisible = false;
  bool _offlineMode = false;

  bool get _isFormValid =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _agentIdController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
    _agentIdController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _agentIdController.dispose();
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
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isObscure,
          style: const TextStyle(color: Colors.black), // ✅ Text color #000000
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
              borderSide: const BorderSide(
                color: Color(0xFFD32F2F),
                width: 2,
              ),
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
            activeColor: const Color(0xFFA61111), // Match splash circle
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
              const Text(
                'Sign in',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              _formField(
                label: 'Username',
                controller: _usernameController,
                hint: 'Username',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                          _showToast('Login successful');
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pushReplacementNamed(context, '/home');
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid
                        ? const Color(0xFFA61111)
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
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
