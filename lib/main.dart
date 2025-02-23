import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utilities/constants.dart';

void main() =>
  runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: kTooltipColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFF421b9b),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
      ),
      home: HomeScreen(),
    );
  }
}