import 'package:codedutravail/core/domain/errors/exceptions.dart';
import 'package:codedutravail/core/domain/errors/failures.dart';
import 'package:codedutravail/core/utils/logger.dart';
import 'package:dio/dio.dart';
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
    AppLogger.error('Error: $err', error: err, stackTrace: st);

    if (err is DioException) {
      if (err.response == null) {
        return Left(NotInternetFailure(null));
      }
      switch (err.response!.statusCode) {
        case 400:
          return Left(BadRequestFailure(null));
        case 401:
          return Left(UnauthorizedFailure(null));
        case 403:
          return Left(ForbiddenFailure(null));
        case 404:
          return Left(NotFoundFailure(null));
        case 429:
          return Left(TooManyRequestsFailure(null));
        case 500:
          return Left(InternalServerFailure(null));
        case 503:
          return Left(ServiceUnavailableFailure(null));
        case 504:
          return Left(RequestTimeoutFailure(null));
        default:
          return Left(UnknownFailure(err as Exception));
      }
    }
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
}
