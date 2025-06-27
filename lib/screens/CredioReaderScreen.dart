import 'package:flutter/material.dart';
import 'DashboardScreen.dart';

void main() => runApp(const CredioReaderScreen());

class CredioReaderScreen extends StatelessWidget {
  const CredioReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsertCardReaderScreen(); // Starts from step 0
  }
}


class StepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const StepProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (i) {
        final isActive = i == currentStep;
        final isDone = i < currentStep;
        final color = isDone || isActive ? Colors.green : Colors.grey.shade400;
        return Row(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: color,
              size: 20,
            ),
            if (i < totalSteps - 1)
              Container(width: 24, height: 2, color: color),
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
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFD32F2F),
        leading:
            Navigator.canPop(context) ? const BackButton(color: Colors.white) : null,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StepProgress(currentStep: step),
          ),
        ),
      ),
      body: Container(
        color: backgroundColor,
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

// 1️⃣ Connect device
class InsertCardReaderScreen extends StatelessWidget {
  const InsertCardReaderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 0,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.bluetooth_searching, size: 72, color: Colors.black),
          SizedBox(height: 24),
          Text(
            'Connect Credio reader',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Please connect the card reader and wait for detection.',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      buttonText: 'Continue',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SelectDeviceScreen()),
        );
      },
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
        children: const [
          Text(
            'Select a device',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListTile(
            tileColor: Colors.black,
            title: Text('Device XYZ'),
            subtitle: Text('00:11:22:33:44'),
          ),
        ],
      ),
      buttonText: 'Continue',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InsertCardScreen()),
        );
      },
    );
  }
}

// 3️⃣ Insert card
class InsertCardScreen extends StatelessWidget {
  const InsertCardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 2,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.credit_card, size: 72, color: Colors.black),
          SizedBox(height: 24),
          Text(
            'Insert your card',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Please insert your card into Credio reader to continue.',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
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
      backgroundColor: Colors.white,
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
          Text('Please verify transaction amount:', style: TextStyle(color: Colors.black54)),
          SizedBox(height: 8),
          Text(
            '₦100,000',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      buttonText: 'Confirm',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EnterPinScreen()),
        );
      },
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
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
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
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF017A36)),
                strokeWidth: 4,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Processing Transaction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Your transaction is being processed.\nPlease wait.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
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
                    child: const Icon(Icons.check, size: 48, color: Color(0xFF017A36)),
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
                          TextSpan(text: 'Payment of ', style: TextStyle(fontSize: 16)),
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
                            MaterialPageRoute(builder: (_) => const DashboardScreen()),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


