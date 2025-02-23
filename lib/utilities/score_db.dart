import 'package:hangMan/utilities/user_score.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final db =
  await openDatabase(join(await getDatabasesPath(), "score_database.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE score (id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT, scoreTime TEXT, userScore INTEGER)",
        );
      }, version: 1);
  return db;
}

Future<void> insertScore(Score score, final database) async {
  final Database db = await database;

  await db.insert(
      'score', score.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
}

Future <List<Score>> scores(final database) async {
  final Database db = await database;
  final List<Map<String, dynamic>>maps = await db.query('score');

  return List.generate(maps.length, (index){
        return Score(id: maps[index]['id'],
            scoreDate: maps[index]['scoreDate'],
            scoreTime: maps[index]['scoreTime'],
            userScore: maps[index]['userScore']);
      });

}

Future<void> updateScore(Score score, final database) async {
  final db = await database;

  await db.update(
    'score',
    score.toMap(),
    where: "id=?",
    whereArgs: [score.id],
  );
}

Future<void> deleteScore(Score score, final Database database) async {
  final db = await database;

  await db.delete('score',
    where: "id=?",
    whereArgs: [score.id],
  );
}

