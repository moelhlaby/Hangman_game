import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class WordButton extends StatelessWidget {
  const WordButton({super.key, required this.letter,required this.onpress,this.ispressed=false});
  final String letter;
  final VoidCallback? onpress;
  final bool ispressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 3.0,
          backgroundColor:ispressed?Colors.grey:kWordButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(4.0),
        ),
        onPressed:onpress,
        child: Text(letter,style: kWordButtonTextStyle,),
      ),
    );
  }
}
