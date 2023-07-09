import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thor_coffee_donut/home/home.dart';
import 'package:thor_coffee_donut/login_sign/login_sign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thor_coffee_donut/main_layout_controller.dart';
import 'package:thor_coffee_donut/providers/food_drink_provider.dart';
import 'package:thor_coffee_donut/providers/login_sign_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginSignProvider()),
        ChangeNotifierProvider(create: (ctx) => FoodDrinkProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainLayoutController();
            } else {
              return const LoginSign();
            }
          },
        ),
      ),
    );
  }
}
