import 'dart:math';

import 'package:flutter/services.dart';

class HangmanWords{
  int wordCounter=0;
  List<int>_userNumbers=[];
  List<String>_words=[];

  Future readWords() async{
    String fileText=await rootBundle.loadString('res/hangman_words.txt');
    print(fileText);
    _words = fileText.split('\n');
    print(_words);
  }

  getWord() async{
    await readWords();
    wordCounter++;
    var ran = Random();
    print(_words);
    int wordLength=_words.length;
    print(wordLength);
    int randNumber=ran.nextInt(wordLength);
    bool notUnique=true;
    if(wordCounter-1==wordLength){
      notUnique=false;
      return'';
    }

    while(notUnique){
      if(!_userNumbers.contains(randNumber)){
        notUnique=false;
        _userNumbers.add(randNumber);
        return _words[randNumber];
      }else{
        randNumber=ran.nextInt(wordLength);
      }
    }

  }
  void resetWords(){
    wordCounter=0;
    List<int>_userNumbers=[];
  }
}