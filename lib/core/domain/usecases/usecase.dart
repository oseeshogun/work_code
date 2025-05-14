import 'dart:async';

import 'package:codedutravail/core/domain/errors/error_wrapper.dart';
import 'package:codedutravail/core/domain/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class SyncUseCase<T> with ErrorWrapper<T> {
  Either<Failure, T> call() => syncWrapper((() => execute()));

  T execute();
}

abstract class UseCase<T> with ErrorWrapper<T> {
  Future<Either<Failure, T>> call() async => await wrapper((() => execute()));

  Future<T> execute();
}

abstract class SyncUseCaseFamily<T, R> with ErrorWrapper<T> {
  Either<Failure, T> call(R param) => syncWrapper((() => execute(param)));

  T execute(R param);
}

abstract class UseCaseFamily<T, R> with ErrorWrapper<T> {
  Future<Either<Failure, T>> call(R param) async => await wrapper(() => execute(param));

  Future<T> execute(R param);
}
