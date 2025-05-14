abstract class Failure {
  final Exception? exception;

  Failure(this.exception);

  String get message;
}

class UnknownFailure extends Failure {
  UnknownFailure(super.exception);

  @override
  String get message => "Une erreur incconnue est survenue.";
}
