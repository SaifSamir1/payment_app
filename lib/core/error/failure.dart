//ده الكلاس الاساسي المتحكم في كل ال failure اللي ممكن تحصل علي مدار البرنامج كله
abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}
