import 'package:dartz/dartz.dart';

import 'package:domain/failures/failure.dart';
import '../entities/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, List<AuthEntity>>> getAuthList();
}
