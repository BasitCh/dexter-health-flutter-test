abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error occurred'])
      : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([String message = 'Unexpected error occurred'])
      : super(message);
}
