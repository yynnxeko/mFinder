import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/tiktok_uid_model.dart';

abstract class TiktokRemoteDataSource {
  Future<TiktokUidModel> getTiktokUid(String profileUrl);
}

class TiktokRemoteDataSourceImpl implements TiktokRemoteDataSource {
  final ApiClient apiClient;

  TiktokRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TiktokUidModel> getTiktokUid(String profileUrl) async {
    final response = await apiClient.post(ApiEndpoints.tiktokUid, {'Link': profileUrl});
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseData['success'] == true) {
        return TiktokUidModel.fromJson(responseData);
      } else {
        throw ServerException(responseData['message'] ?? 'Unknown error');
      }
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      final errorMessage = responseData['message'] ?? responseData['error'] ?? 'Server error';
      throw ServerException('Error ${response.statusCode}: $errorMessage');
    } else {
      throw ServerException('Failed: ${response.reasonPhrase}');
    }
  }
}