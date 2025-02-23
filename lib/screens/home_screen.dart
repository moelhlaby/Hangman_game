import 'package:flutter/material.dart';
import 'package:hangMan/components/action_button.dart';
import 'package:hangMan/screens/game_screen.dart';
import 'package:hangMan/screens/loading_screen.dart';

import '../utilities/hangman_words.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HangmanWords hangmanWords = HangmanWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                child: const Text(
                  'HANGMAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 58.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3.0),
                ),
              ),
              const Expanded(
                child: Image(
                  image: AssetImage(
                    'images/gallow.png',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ActionButton(
                    title: 'Start',
                    buttonAction: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          hangmanObject: hangmanWords,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ActionButton(title: 'HighScore',buttonAction: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  ),),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
