import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/tiktok_repository.dart';
import '../datasources/tiktok_remote_datasource.dart';
import '../../domain/entities/tiktok_uid_entity.dart';

class TiktokRepositoryImpl implements TiktokRepository {
  final TiktokRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TiktokRepositoryImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, TiktokUidEntity>> getTiktokUid(String profileUrl) async {
    if (await networkInfo.isConnected) {      try {
        final remoteUidModel = await remoteDataSource.getTiktokUid(profileUrl);
        
        // Validate that we got a valid UID
        if (remoteUidModel.uid.isEmpty) {
          return Left(ServerFailure('No UID found in response. Please check if the TikTok URL is valid.'));
        }
        
        // Convert model to entity (in this case, model already extends entity, so it's fine)
        final TiktokUidEntity entity = TiktokUidEntity(uid: remoteUidModel.uid);
        print('✅ TikTok UID extracted successfully: ${entity.uid}');
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