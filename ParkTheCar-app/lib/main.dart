import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_pageapp/features/app/splash_screen/splash_screen.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/HomePage.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/LoginPage.dart';
import 'package:login_pageapp/features/user_auth/presentation/pages/spacesPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDnDbf_dm_wL1ZvT1DV6CdulVPz84e5q40",
    appId: '1:307703673940:android:48c26f84ee06b9a38d69c1',
    messagingSenderId: '307703673940',
    projectId: "carparking-d4dbd",
    storageBucket: "carparking-d4dbd.appspot.com",
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          SpacesPage.routeName: (context) => SpacesPage(),
        },
        // home: HomePage());
        home: SplashScreen(
          child: LoginPage(),
        ));
  }
}
