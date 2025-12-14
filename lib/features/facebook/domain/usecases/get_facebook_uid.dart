import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/input_validator.dart';
import '../entities/facebook_uid_entity.dart';
import '../repositories/facebook_repository.dart';
import 'facebook_uid_params.dart';

class GetFacebookUidUseCase extends UseCase<FacebookUidEntity, FacebookUidParams> {
  final FacebookRepository repository;

  GetFacebookUidUseCase(this.repository);

  @override
  Future<Either<Failure, FacebookUidEntity>> call(FacebookUidParams params) async {
    // Validate input
    final validation = InputValidator.validateFacebookUrl(params.profileUrl);
    if (validation.isLeft()) {
      return Left((validation as Left<Failure, String>).value);
    }
    
    // Call repository with validated URL
    return await repository.getFacebookUid(validation.getOrElse(() => ''));
  }
}