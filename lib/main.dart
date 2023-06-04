import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:igcloneapp/screens/login_screen.dart';
import 'package:igcloneapp/screens/signup_screen.dart';
import 'package:igcloneapp/utils/colors.dart';
import 'package:igcloneapp/responsive/mobile_screen_layout.dart';
import 'package:igcloneapp/responsive/responsive_layout.dart';
import 'package:igcloneapp/responsive/web_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCg_oO7bojKT3vjpVken79dM1gYG9E_PZ4',
            appId: '1:1092994237147:web:f88dde26ff6c230a9a02fe',
            messagingSenderId: '1092994237147',
            projectId: 'fotogram-clone',
            storageBucket: 'fotogram-clone.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  web_screen_layout: WebLayout(),
                  mobile_screen_layout: MobileLayout());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const  Center(
              child:  CircularProgressIndicator(
                  backgroundColor: primaryColor),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
