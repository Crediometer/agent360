import 'package:agent360/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';

// void main() => runApp(CredioReaderApp());

class CredioReaderScreen extends StatelessWidget {
  const CredioReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InsertCardScreen(); // Starts the transaction flow
  }
}

class StepProgress extends StatelessWidget {
  final int currentStep;

  StepProgress({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isCompleted = index < currentStep;
        bool isCurrent = index == currentStep;

        return Row(
          children: [
            Icon(
              isCompleted
                  ? Icons.check_circle
                  : isCurrent
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isCompleted || isCurrent ? Colors.green : Colors.grey,
              size: 20,
            ),
            if (index < 2)
              Container(
                width: 40,
                height: 2,
                color: (index < currentStep - 1) ? Colors.green : Colors.grey,
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
  final VoidCallback? onButtonPressed;
  final String? buttonText;

  BaseScreen({
    required this.title,
    required this.step,
    required this.content,
    this.onButtonPressed,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white), // White title text
        ),
        backgroundColor: Colors.red[800],
        // actions: [Icon(Icons.account_circle_outlined, color: Colors.white)],
        leading: Navigator.canPop(context)
            ? BackButton(color: Colors.white)
            : null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: StepProgress(currentStep: step),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(child: content),
            if (buttonText != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    buttonText!,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Screen 1: Insert Your Card
class InsertCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.credit_card, size: 48),
          SizedBox(height: 16),
          Text(
            "Insert your card",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Please connect the card reader and insert your card. Wait for the card to be detected.",
          ),
        ],
      ),
      buttonText: 'Continue',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ConfirmAmountScreen()),
        );
      },
    );
  }
}

// Screen 2: Confirm Transaction Amount
class ConfirmAmountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 1,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, size: 48, color: Colors.black),
          SizedBox(height: 16),
          Text(
            "Confirm Transaction Amount",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Please verify the transaction amount: ",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "100.000 \$",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("Confirm to proceed."),
        ],
      ),
      buttonText: 'Confirm',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EnterPinScreen()),
        );
      },
    );
  }
}

// Screen 3: Enter Your PIN
class EnterPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Credio Reader',
      step: 2,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline, size: 48),
          SizedBox(height: 16),
          Text(
            "Enter Your PIN",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("Insert your PIN to authorize the transaction."),
        ],
      ),
      buttonText: 'Continue',
      onButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProcessingScreen()),
        );
      },
    );
  }
}

// Screen 4: Processing Transaction
class ProcessingScreen extends StatefulWidget {
  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TransactionSuccessScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Add New Customer',
      step: 3,
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.green),
            SizedBox(height: 24),
            Text(
              "Processing Transaction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Your transaction is being processed.\nPlease wait.",
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
      backgroundColor: Colors.red[800],
      body: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0F2E9),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(
                      Icons.check,
                      size: 48,
                      color: Colors.white,
                    ),
                    foregroundDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("Great!", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Payment of "),
                        TextSpan(
                          text: "100.000\$",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " successfully processed."),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Thank you for your transaction!",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
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
                        backgroundColor: Colors.red[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Back to dashboard",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
