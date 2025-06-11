import 'package:agent360/screens/Auth/ForgotPasswordScreen.dart';
import 'package:agent360/screens/Auth/Login.dart';
import 'package:agent360/screens/Tabs.dart';
import 'package:flutter/material.dart';

import 'screens/SplashScreen.dart';
import 'screens/OnBoardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'agent 360',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffa20a09)),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/home': (context) => const MainLayout(),

      },
      home: const SplashScreen(),
    );
  }
}
