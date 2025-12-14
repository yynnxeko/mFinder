import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_validator.dart';
import '../entities/tiktok_uid_entity.dart';
import '../repositories/tiktok_repository.dart';
import 'tiktok_uid_params.dart';

class GetTiktokUidUseCase extends UseCase<TiktokUidEntity, TiktokUidParams> {
  final TiktokRepository repository;

  GetTiktokUidUseCase(this.repository);

  @override
  Future<Either<Failure, TiktokUidEntity>> call(TiktokUidParams params) async {
    // Validate input
    final validation = InputValidator.validateTiktokUrl(params.profileUrl);
    if (validation.isLeft()) {
      return Left((validation as Left<Failure, String>).value);
    }
    
    // Call repository with validated URL
    return await repository.getTiktokUid(validation.getOrElse(() => ''));
  }
}