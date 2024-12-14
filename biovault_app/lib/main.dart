import 'package:flutter/material.dart';
import 'obboarding_pages/onboarding.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding App',
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

// Dummy HomeSreen for testing
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Color(0xFF2F0236),
      ),
      body: Center(
        child: Text(
          'Home Screen!',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
