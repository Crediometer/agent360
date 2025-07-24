import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      showSkipButton: false,
      pages: [
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Image.asset("assets/Woman-Jump-On-Money.png", height: 400),
                const SizedBox(height: 20),
                const Text(
                  "Savings",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Help customers save smartly and grow their wealth",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Image.asset("assets/Card-Secure.png", height: 400),
                const SizedBox(height: 20),
                const Text(
                  "Transactions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Manage seamless transactions securely for your customers",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: const SizedBox.shrink(),
          bodyWidget: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                Image.asset("assets/Paying-Money.png", height: 400),
                const SizedBox(height: 20),
                const Text(
                  "Loans",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Assist customers in accessing quick and flexible loan options",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  }
}
