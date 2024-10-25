import 'package:adv_flutter_final_exam/provider/expense_provider.dart';
import 'package:adv_flutter_final_exam/services/auth.dart';
import 'package:adv_flutter_final_exam/views/home_screen.dart';
import 'package:adv_flutter_final_exam/views/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ExpenseProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (AuthServices.userServices.getCurrentUser() != null)
          ? const HomeScreen()
          : const SignInScreen(),
    );
  }
}
