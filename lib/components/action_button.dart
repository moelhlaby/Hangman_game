import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangMan/utilities/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.title, this.buttonAction});
  final String title;
  final VoidCallback? buttonAction;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(

      onPressed: buttonAction,
      style: ElevatedButton.styleFrom(
        foregroundColor:kActionButtonHighlightColor,
        backgroundColor:kActionButtonColor ,
        elevation:3.0 ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      child: Container(
        height:MediaQuery.of(context).size.width / 9 ,
        width: MediaQuery.of(context).size.width / 4,
        child: Center(child: Text(title,style: kActionButtonTextStyle, )),
      ),
    );
  }
}
