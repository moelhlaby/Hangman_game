class Score {
  final int id;
  final String scoreDate;
  final String scoreTime;
  final int userScore;

  Score( {required this.id, required this.scoreDate, required this.userScore,required this.scoreTime,});

  Map<String, dynamic> toMap() {
    return {'scoreDate': scoreDate, 'userScore': userScore,'scoreTime':scoreTime};
  }

  @override
  String toString() {
    return '$userScore,$scoreTime,$scoreDate,$id';
  }
}
