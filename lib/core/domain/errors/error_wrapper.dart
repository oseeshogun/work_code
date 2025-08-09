import 'package:codedutravail/core/domain/errors/exceptions.dart';
import 'package:codedutravail/core/domain/errors/failures.dart';
import 'package:codedutravail/core/utils/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fpdart/fpdart.dart';

import 'failures/https.dart';

mixin ErrorWrapper<T> {
  Future<Either<Failure, T>> wrapper(Future<T> Function() execute) async {
    try {
      return Right<Failure, T>(await execute.call());
    } catch (err, st) {
      return FailureResolver.resolveLeft(err, st);
    }
  }

  Either<Failure, T> syncWrapper(T Function() execute) {
    try {
      return Right<Failure, T>(execute.call());
    } catch (err, st) {
      return FailureResolver.resolveLeft(err, st);
    }
  }
}

abstract class FailureResolver {
  static Left<Failure, T> resolveLeft<T>(Object err, StackTrace st) {
    // Log error to console
    AppLogger.error('Error: $err', error: err, stackTrace: st);

    // Report error to Firebase Crashlytics
    _reportToCrashlytics(err, st);

    if (err is CustomException) {
      switch (err) {
        case UnauthorizedException():
          return Left(UnauthorizedFailure(null));
      }
    } else if (err is TypeError) {
      return Left(UnauthorizedFailure(null));
    }
    return Left(UnknownFailure(err as Exception));
  }

  /// Reports errors to Firebase Crashlytics
  static void _reportToCrashlytics(Object error, StackTrace stackTrace) {
    try {
      // Get the Crashlytics instance
      final crashlytics = FirebaseCrashlytics.instance;

      // Add custom keys to provide more context
      crashlytics.setCustomKey('error_type', error.runtimeType.toString());

      // Record the error
      crashlytics.recordError(
        error,
        stackTrace,
        reason: 'Error caught by ErrorWrapper',
        // Mark as non-fatal since the app can continue
        fatal: false,
      );
    } catch (e) {
      // If reporting to Crashlytics fails, just log it
      AppLogger.error('Failed to report to Crashlytics: $e');
    }
  }
}
