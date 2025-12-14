import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/tiktok_uid_entity.dart';

abstract class TiktokRepository {
  Future<Either<Failure, TiktokUidEntity>> getTiktokUid(String profileUrl);
}