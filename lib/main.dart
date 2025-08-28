import 'package:agent360/features/screens/Auth/screens/ForgotPasswordScreen.dart';
import 'package:agent360/features/screens/Auth/screens/Login.dart';
import 'package:agent360/features/screens/profile/screens/user_debug_screen.dart';
import 'package:agent360/features/screens/shared/screens/AuthGuard.dart';
import 'package:agent360/features/screens/shared/screens/Tabs.dart';
import 'package:agent360/features/screens/shared/screens/OfflineDataScreen.dart';
import 'package:agent360/models/user_model.dart';
import 'package:agent360/services/offline_storage_service.dart';
import 'package:agent360/services/network_service.dart';
import 'package:flutter/material.dart';
import 'features/screens/shared/screens/SplashScreen.dart';
import 'features/screens/onboarding/screens/OnBoardingScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');

  // Initialize offline services
  await OfflineStorageService.initialize();
  await NetworkService().initialize();

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
        '/debug-users': (_) => const UserDebugScreen(),
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/home': (context) => const AuthGuard(child: MainLayout()),
        '/offline-data': (context) => const OfflineDataScreen(),

      },
      home: const UserDebugScreen(),

    );
  }
}
