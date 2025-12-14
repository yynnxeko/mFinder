import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/facebook_repository.dart';
import '../datasources/facebook_remote_datasource.dart';
import '../../domain/entities/facebook_uid_entity.dart';

class FacebookRepositoryImpl implements FacebookRepository {
  final FacebookRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FacebookRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, FacebookUidEntity>> getFacebookUid(String profileUrl) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUidModel = await remoteDataSource.getFacebookUid(profileUrl);
        // Convert model to entity (in this case, model already extends entity, so it's fine)
        final FacebookUidEntity entity = FacebookUidEntity(uid: remoteUidModel.uid);
        return Right(entity);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }    } else {
      return Left(NetworkFailure('No internet connection. Please check your connection and try again.'));
    }
  }
}