import 'package:flutter/material.dart';
import '../../dashboard/screens/DashboardScreen.dart';

void main() => runApp(const CredioReaderScreen());

class CredioReaderScreen extends StatelessWidget {
  const CredioReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsertCardReaderScreen();
  }
}

class StepProgress extends StatelessWidget {
  final int currentStep;
  const StepProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) {
        bool active = i == currentStep;
        bool done = i < currentStep;
        return Row(
          children: [
            Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              color: done || active ? Colors.green : Colors.grey.shade400,
              size: 20,
            ),
            if (i < 3)
              Container(
                width: 24,
                height: 2,
                color: done ? Colors.green : Colors.grey.shade400,
              ),
          ],
        );
      }),
    );
  }
}

class BaseScreen extends StatelessWidget {
  final String title;
  final int step;
  final Widget content;
  final VoidCallback? onNext;
  final String? buttonText;
  final Color backgroundColor;

  const BaseScreen({
    super.key,
    required this.title,
    required this.step,
    required this.content,
    this.onNext,
    this.buttonText,
    this.backgroundColor = Colors.white, // default value
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // 🔥 use here
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFD32F2F),
        leading: Navigator.canPop(context)
            ? const BackButton(color: Colors.white)
            : null,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StepProgress(currentStep: step),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(child: content),
            if (buttonText != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    buttonText!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ConnectionStatusIndicator extends StatefulWidget {
  final bool isConnected;
  const ConnectionStatusIndicator({super.key, required this.isConnected});
  @override
  _ConnectionStatusIndicatorState createState() =>
      _ConnectionStatusIndicatorState();
}

class _ConnectionStatusIndicatorState extends State<ConnectionStatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = widget.isConnected;
    final outerColor = isConnected
        ? Colors.green.shade800
        : const Color(0xFFB11226);
    final middleColor = isConnected ? Colors.green : const Color(0xFFD32F2F);
    final innerColor = isConnected
        ? Colors.green.shade100
        : Colors.grey.shade200;
    final text = isConnected ? 'Connected' : 'Searching...';

    return ScaleTransition(
      scale: _pulse,
      child: Container(
        width: 117,
        height: 117,
        decoration: BoxDecoration(color: outerColor, shape: BoxShape.circle),
        child: Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: middleColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: innerColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InsertCardReaderScreen extends StatefulWidget {
  const InsertCardReaderScreen({super.key});
  @override
  State<InsertCardReaderScreen> createState() => _InsertCardReaderScreenState();
}

class _InsertCardReaderScreenState extends State<InsertCardReaderScreen> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    // Simulate device detection (replace with actual logic)
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isConnected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 0,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConnectionStatusIndicator(isConnected: isConnected),
          const SizedBox(height: 24),
          const Icon(Icons.bluetooth_searching, size: 72, color: Colors.black),
          const SizedBox(height: 24),
          const Text(
            'Connect Credio reader',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Please connect the card reader and wait for detection.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      buttonText: 'Continue',
      onNext: isConnected
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SelectDeviceScreen()),
              );
            }
          : null, // disabled until connected
    );
  }
}

// 2️⃣ Device selection
class SelectDeviceScreen extends StatelessWidget {
  const SelectDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 1,
      backgroundColor: Colors.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 24),
          Text(
            'Select a device',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListTile(
            tileColor: Colors.white,
            title: Text('Adewumi George'),
            subtitle: Text('00:11:22:33:44'),
          ),
        ],
      ),
      buttonText: 'Continue',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ConfirmAmountScreen()),
        );
      },
    );
  }
}

// 4️⃣ Confirm Amount
class ConfirmAmountScreen extends StatelessWidget {
  const ConfirmAmountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 3,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle_outline, size: 72, color: Colors.red),
          SizedBox(height: 24),
          Text(
            'Confirm Transaction Amount',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Please verify transaction amount:',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 8),
          Text(
            '₦100,000',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      buttonText: 'Confirm',
      onNext: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EnterPinScreen()),
      ),
    );
  }
}

// 5️⃣ Enter PIN
class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void _submitPin() {
    final pin = _controllers.map((c) => c.text).join();
    if (pin.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProcessingScreen()),
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 4,
      backgroundColor: Colors.white,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lock_outline, size: 40),
          const SizedBox(height: 16),
          const Text(
            'Enter Your PIN',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Insert your PIN to authorize the transaction.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (i) {
              return SizedBox(
                width: 60,
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  maxLength: 1,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 24),
                  onChanged: (value) {
                    if (value.isNotEmpty && i < 3) {
                      FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                    } else if (value.isEmpty && i > 0) {
                      FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                    }
                  },
                ),
              );
            }),
          ),
        ],
      ),
      buttonText: 'Continue',
      onNext: _submitPin,
    );
  }
}

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});
  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TransactionSuccessScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFF017A36)),
            ),
            SizedBox(height: 24),
            Text(
              'Processing Transaction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            Text(
              'Your transaction is being processed. Please wait.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA70F1A), // deep red background
      body: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFF5E3), // light green circle
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 48,
                      color: Color(0xFF017A36),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Great!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Payment of ',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                            text: '100.000\$',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF017A36), // green
                            ),
                          ),
                          TextSpan(
                            text: '\nsuccessfully processed.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Thank you for your transaction!',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA70F1A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Back to dashboard',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
