import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Colors based on theme
  final List<Color> _colors = [Color(0xFF2F0236), Color(0xFF6C0354), Color(0xFFAA0473)];

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  // Check if this is the first launch --> this uses shared preferences
  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (!isFirstTime) {
      _navigateToHome();
    }
  }

  // Set first launch as false
  Future<void> _setFirstTimeFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_time', false);
  }

  // Navigate to the home page afterwards
  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            //dummy strings for testing
            children: [
              _buildPage('a', 'a', 'assets/first.png', _colors[0]),
              _buildPage('b', 'b', 'assets/second.png', _colors[1]),
              _buildPage('c', 'c', 'assets/third.png', _colors[2]),
            ],
          ),
          _buildSkipButton(),
          _buildIndicator(),
        ],
      ),
    );
  }

  // Skip button
  Widget _buildSkipButton() {
    return Positioned(
      top: 40.0,
      right: 16.0,
      child: TextButton(
        onPressed: () async {
          await _setFirstTimeFalse();
          _navigateToHome();
        },
        child: const Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  // Page indicator
  Widget _buildIndicator() {
    return Positioned(
      bottom: 20.0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
              (index) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            height: 8.0,
            width: _currentPage == index ? 24.0 : 8.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? _colors[index] : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  // Onboarding page content
  Widget _buildPage(String title, String description, String imagePath, Color bgColor) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 300.0, fit: BoxFit.cover),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
