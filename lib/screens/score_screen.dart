import 'package:flutter/material.dart';
import 'package:hangMan/screens/home_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utilities/constants.dart';
import '../utilities/user_score.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key, required this.query});
  final List<Score> query;

  @override
  Widget build(BuildContext context) {
    List<String> topRanks = ["🥇", "🥈", "🥉"];
    return Scaffold(
      body: query==null?CircularProgressIndicator(): SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   IconButton(
                    iconSize: 39,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    },
                    icon: Icon(
                      MdiIcons.home,
                    ),
                  ),
                  Expanded(child: Center(child: Text('High Scores',style: kHighScoreTableHeaders,)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0,30,12,8),
              child: Table(
                children:  [
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Center(child: TableCell(child: Text('Rank',style: kHighScoreTableRowsStyle,))),
                      ),
                      Center(child: TableCell(child: Text('Date',style: kHighScoreTableRowsStyle,))),
                      Center(child: TableCell(child: Text('Score',style: kHighScoreTableRowsStyle,))),

                    ]
                  ),
                  for (int i=0;i<query.length;i++)TableRow(
                    children: [
                      TableCell(child: Center(child: Text('${i<3?topRanks[i]:i+1}',style:kHighScoreTableRowsStyle ,)),),
                      TableCell(child: Center(child: Text("${query[i].scoreTime }\n${query[i].scoreDate }",style: kHighScoreTableRowsStyle,)),),
                      TableCell(child: Center(child: Text("${query[i].userScore}",style: kHighScoreTableRowsStyle,)),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
