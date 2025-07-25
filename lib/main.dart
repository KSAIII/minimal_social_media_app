import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/auth/auth.dart';
import 'package:socialmedia_app/auth/login_or_register.dart';
import 'package:socialmedia_app/firebase_options.dart';
import 'package:socialmedia_app/pages/homepage.dart';
import 'package:socialmedia_app/pages/profile_page.dart';
import 'package:socialmedia_app/pages/users_page.dart';
import 'package:socialmedia_app/themes/dark_mode.dart';
import 'package:socialmedia_app/themes/light_mode.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
    '/login_register_paage':(context)=>LoginOrRegister(),
    '/home_page':(context)=> Homepage(),
    '/profile_page':(context)=> ProfilePage(),
    '/users_page':(context)=>const UsersPage(),

      },

    );
  }
}