import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/failures/failure.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetAuthListUseCase {
  const GetAuthListUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, List<AuthEntity>>> call() {
    return _repository.getAuthList();
  }
}
