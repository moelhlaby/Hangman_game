import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangMan/components/word_button.dart';
import 'package:hangMan/screens/home_screen.dart';
import 'package:hangMan/utilities/alphabet.dart';
import 'package:hangMan/utilities/hangman_words.dart';
import 'package:hangMan/utilities/user_score.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utilities/constants.dart';
import '../utilities/score_db.dart'as score_database;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.hangmanObject});
  final HangmanWords hangmanObject;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final score_db=score_database.openDB();
  Alphabet alphabet = Alphabet();
  int score = 0;
  late String s_word;
  List<String> word = [];
  List correctLetters = [];
  List wrongLetters = [];
  int lives = 2 ;
  int hints=0;

  int getWordSet(){
    return word.toSet().toList().length;
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void initWord()async{
    s_word =await widget.hangmanObject.getWord();
    print(s_word);
    word=s_word.split('');
    print(word);
    correctLetters = [];
    wrongLetters = [];
    hints=0;

  }
  void initGame(){
    setState(() {
      widget.hangmanObject.resetWords();
      correctLetters = [];
      wrongLetters = [];
      score = 0;
      lives = 5;
      initWord();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                iconSize: 39,
                onPressed: () {
                },
                icon: Icon(
                  MdiIcons.heart,
                ),
              ),
              Text(
                lives>=0?'$lives':'${lives+1}',
                style: const TextStyle(
                    fontSize: 25,
                    color: Color(0xFF421b9b),
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Text(
            '$score',
            style: kWordCounterTextStyle,
          ),
          IconButton(
            onPressed:hints<1? () {hintFunc();
              hints++;}:(){},
            icon: Icon(
              MdiIcons.lightbulb,
            ),
            iconSize: 39,
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Image(
            image: AssetImage("images/${wrongLetters.length}.png"),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5, 5, 15),
          child: Container(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (String wordLetter in word)
                  correctLetters.contains(wordLetter)
                      ? Text('$wordLetter'.toUpperCase(), style: kWordTextStyle,)
                      : const Text('_', style: kWordTextStyle),
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
        child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            // columnWidths: {1: FlexColumnWidth(10)},
            children: [
              TableRow(
                children: [
                  for (int index = 0; index < 7; index++)
                    index < alphabet.alphabet.length
                        ? TableCell(
                            child: buttonsRow(alphabet.alphabet[index]),
                          )
                        : const TableCell(child: Text('')),
                ],
              ),
              TableRow(
                children: [
                  for (int index = 7; index < 14; index++)
                    index < alphabet.alphabet.length
                        ? TableCell(
                            child: buttonsRow(alphabet.alphabet[index]),
                          )
                        : const TableCell(child: Text('')),
                ],
              ),
              TableRow(
                children: [
                  for (int index = 14; index < 21; index++)
                    index < alphabet.alphabet.length
                        ? TableCell(
                            child: buttonsRow(alphabet.alphabet[index]),
                          )
                        : const TableCell(child: Text('')),
                ],
              ),
              TableRow(
                children: [
                  for (int index = 21; index < 28; index++)
                    index < alphabet.alphabet.length
                        ? TableCell(
                            child: buttonsRow(alphabet.alphabet[index]),
                          )
                        : const TableCell(child: Text('')),
                ],
              ),
            ]),
      ),
    ])));
  }

  void onPressWordButton(String letter) {
            if (word.contains(letter)) {
                setState(() {
                  correctLetters.add(letter);
                });
            } else {
              if(wrongLetters.length==5){
                setState(() {
                  lives--;
                initWord();
                  if(lives>0){Alert(
                    context: context,
                    style: kFailedAlertStyle,
                    type: AlertType.error,
                    title: word.join().toString(),
                    buttons: [
                      DialogButton(
                        radius: BorderRadius.circular(10),
                        width: 127,
                        color: kDialogButtonColor,
                        height: 52,
                        child: Icon(
                          MdiIcons.arrowRightThick,
                          size: 30.0,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            initWord();
                          });
                        },
                      ),
                    ],
                  ).show();}

                });
              }else{
                setState(() {
                  wrongLetters.add(letter);
                });

              }
              if(lives==0){
                if(score>0){Score sco=Score(
                  id: 1,
                  scoreTime: DateFormat.jm().format(DateTime.now()).toString(),
                  scoreDate: DateFormat.MMMd().format(DateTime.now()).toString(),
                  userScore: score
                );
                score_database.insertScore(sco, score_db);
                }
                Alert(
                    style: kGameOverAlertStyle,
                    context: context,
                    title: "Game Over!",
                    desc: "Your score is $score",
                    buttons: [
                      DialogButton(
                        color: kDialogButtonColor,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          MdiIcons.home,
                          size: 30.0,
                        ),
                      ),
                      DialogButton(
                        onPressed: () {
                          initGame();
                          Navigator.pop(context);

                        },
                        color: kDialogButtonColor,
                        child: Icon(MdiIcons.refresh, size: 30.0),
                      ),
                    ]
                ).show();
              }
              }

            if (correctLetters.length==getWordSet()) {
              setState(() {
                score++;
              initWord();
                Alert(
                  context: context,
                  style: kSuccessAlertStyle,
                  type: AlertType.success,
                  title: word.join().toString(),
                  buttons: [
                    DialogButton(
                      radius: BorderRadius.circular(10),
                      width: 127,
                      color: kDialogButtonColor,
                      height: 52,
                      child: Icon(
                        MdiIcons.arrowRightThick,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show();

              });
              print('winner');
            };
  }

  Widget buttonsRow(String letter) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: WordButton(
            ispressed:
                correctLetters.contains(letter) || wrongLetters.contains(letter)
                    ? true
                    : false,
            letter: letter.toUpperCase(),
            onpress:correctLetters.contains(letter) || wrongLetters.contains(letter)
                ? () {}
                :()=>onPressWordButton(letter),
        ),
      ),
    );
  }

  void hintFunc(){
    var ran = Random();
    var hintIndex=ran.nextInt(word.length);
    if(!correctLetters.contains(word[hintIndex])){
      setState(() {
        correctLetters.add(word[hintIndex]);
      });
    }
    else{
      hintFunc();
    }
  }
}
