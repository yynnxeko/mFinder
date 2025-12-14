import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/facebook_uid_entity.dart';

abstract class FacebookRepository {
  Future<Either<Failure, FacebookUidEntity>> getFacebookUid(String profileUrl);
}