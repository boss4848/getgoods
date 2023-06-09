import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'pages/main/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Goods',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: TextStyle(
            color: secondaryTextColor,
            fontSize: 18,
            // fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: secondaryTextColor,
            fontSize: 12,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
