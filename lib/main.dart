import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saathi_task/repositories/firebase/firebase_auth.dart';

import 'features/auth/login/provider/login_provider.dart';
import 'features/auth/login/screens/login.dart';
import 'features/auth/signup/provider/signup_provider.dart';
import 'features/home/provider/create_checklist.dart';
import 'features/home/provider/home_provider.dart';
import 'features/home/screens/home_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    ),
    ChangeNotifierProvider<SignupProvider>(
      create: (context) => SignupProvider(),
    ),
    ChangeNotifierProvider<AuthHelper>(
      create: (context) => AuthHelper(),
    ),
    ChangeNotifierProvider<CreateChecklistProvider>(
      create: (context) => CreateChecklistProvider(),
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          context.read<AuthHelper>().isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
