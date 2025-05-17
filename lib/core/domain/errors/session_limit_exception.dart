import 'package:codedutravail/core/domain/errors/failures.dart';

/// Exception thrown when a user has reached their daily session limit
class SessionLimitException implements Exception {
  final String message;
  
  SessionLimitException({
    this.message = 'Vous avez atteint la limite quotidienne de sessions.'
  });
  
  @override
  String toString() => message;
}

/// Failure representing a session limit exceeded error
class SessionLimitFailure extends Failure {
  SessionLimitFailure([super.exception]);
  
  @override
  String get message => exception is SessionLimitException 
    ? (exception as SessionLimitException).message 
    : 'Vous avez atteint la limite quotidienne de sessions.';
}
