import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hangMan/screens/score_screen.dart';
import 'package:hangMan/utilities/user_score.dart';
import '../utilities/score_db.dart'as score_database;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();

}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    queryScore();
  }

  void queryScore()async{
    final database = score_database.openDB();
    List<Score> queryResult=await score_database.scores(database);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScoreScreen(query: queryResult),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
